#!/bin/env ruby
# encoding: utf-8

class CharactersController < ApplicationController
  def new
    @character = Character.new
  end
  
  def create
    #@character = Character.new(params[:character])
    p "chara sex is >>>>>>>>"
    p params[:character][:sex]
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
      if session[:uke] != "nil"
        redirect_to :controller => :cps, :action => :new
      else
        redirect_to :controller => :characters, :action => :new
      end
    else
      render :action => new
    end
  end

  def show
    @character = Character.find_by_id(params[:id])
  end
end