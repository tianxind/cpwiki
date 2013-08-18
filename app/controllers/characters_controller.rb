#!/bin/env ruby
# encoding: utf-8

class CharactersController < ApplicationController
  def new
    @character = Character.new
  end
  
  def create
    #@character = Character.new(params[:character])
    p "chara params is >>>>>>>>"
    p params[:character]
    @character = Character.new(:name => params[:character][:name],
                               :nickname => params[:character][:nickname],
                               :birth_date => params[:character][:birth_date],
                               :horoscope => params[:character][:horoscope],
                               :blood_type => params[:character][:blood_type],
                               :hair => params[:character][:hair],
                               :eye => params[:character][:eye],
                               :height => params[:character][:height],
                               :weight => params[:character][:weight],
                               :occupation => params[:character][:occupation],
                               :summary => params[:character][:summary])
                               
    # sex_array = ["男", "女", "不明", "其他"]
    # @character.sex = sex_array[params[:character][:sex].to_i]
    @character.sex = params[:sex]
    if @character.save!
      if session[:seme] == "nil"
        session[:seme] = @character.id 
        p "in assigning session[:seme]"
      elsif session[:uke] == "nil"
        session[:uke] = @character.id
        p "in assigning session[:uke]"
      end
      # see if there are any images we need to delete
      pos = 0
      wiki_content = params[:character][:summary]
      files = Array.new
      while pos < wiki_content.length do
        # Get file name of the image
        match_data = wiki_content.match(/<img(.+)src=\"\/images\/(.+)\">/, pos)
        if match_data != nil
          files.push(match_data[2])
          pos += 4
        else
          break
        end
      end
      # puts "<<<<<<<<<<<<<<<<<<<all images in wikisource<<<<<<<<<<<<<<"
      # puts files
      deleted_files = params[:images].reject {|i| files.include? i}
      # puts "<<<<<<<<<<<<<<<<<<<<Deleted files<<<<<<<<<<<<<<<<<<<<<<<"
      # puts deleted_files
      # Delete all entries from database and the files on our server
      deleted_files.each do |f|
        image = Photo.find_by_filename(f)
        image.destroy
        File.delete(Rails.root.join('public', 'images', image.filename))
      end
    
      # If both seme and uke are nil, then the user intends to only create character
      if session[:seme] == nil && session[:uke] == nil
        # for only create a single character
        redirect_to :controller => :characters, :action => :show, :id => @character.id
      # Otherwise the user intends to create a cp 
      else
        if session[:seme] == "nil"
          session[:seme] = @character.id 
          p "in assigning session[:seme]"
        elsif session[:uke] == "nil"
          session[:uke] = @character.id
          p "in assigning session[:uke]"
        end
        if session[:uke] != "nil"
          redirect_to :controller => :cps, :action => :new
        else
          redirect_to :controller => :characters, :action => :new
        end
      end
    else
      # Delete all files ???
      render :action => new
    end
  end

  def show
    @character = Character.find_by_id(params[:id])
  end
  
  def edit
  end
end