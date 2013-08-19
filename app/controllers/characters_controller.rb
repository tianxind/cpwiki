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
                               :summary => params[:summary])
                               
    # sex_array = ["男", "女", "不明", "其他"]
    # @character.sex = sex_array[params[:character][:sex].to_i]
    @character.sex = params[:sex]

    profile_image = params[:character][:profile_image]
    time = Time.now
    image_filename = current_user.id.to_s + "_" + profile_image.original_filename
    @photo = Photo.new(:date_time => time, 
                       :filename => image_filename, 
                       :user_id => current_user.id)
    if @photo.save
        File.open(Rails.root.join('public', 'images', @photo.filename), 'wb') do |file|
          file.write(profile_image.read)
        end
      end
    @character.profile_image = @photo.id

    if @character.save!     
      # see if there are any images we need to delete
      if params[:images] != nil
        Photo.deleteUnusedImages(params[:summary], params[:images])
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
    @character = Character.find_by_id(params[:id])
  end

  def choose 
  end
  
  def search
    params[:chara].strip!
    @chara = Character.search(params[:chara])
  end
  
  def redirect_to_character_info_or_new_character
    p "new chara name is >>>>>>>>>"
    p params[:new_chara]
    p params[:chara]
    if params[:new_chara] == "nil"
      p ">>>>>>>create new chara"
      redirect_to :controller => :characters, :action => :new
    else
      p ">>>>>>>show old chara"
      redirect_to :controller => :characters, :action => :show, :id => params[:new_chara]
    end
  end

end