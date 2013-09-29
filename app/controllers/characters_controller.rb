#!/bin/env ruby
# encoding: utf-8

class CharactersController < ApplicationController
  include Sanitize

  before_filter :authenticate_user!, :except => [:show, :search, :redirect_to_character_info_or_new_character]

  def new
    # redirect user to characters/choose if user type in /characters/new
    if session[:new_chara_name] == nil && session[:seme] == nil && session[:uke] == nil
      redirect_to :controller => :characters, :action => :choose
    end
    @character = Character.new
  end
  
  def create
    #@character = Character.new(params[:character])
    p "chara params is >>>>>>>>"
    p params
    p "sex is "
    p params[:sex]

    @character = Character.new(params[:character])
    @character.creator_id = current_user.id
    @character.created_at = Time.now
    @character.summary = params[:summary]

    sanitize(@character.summary)

    # check chara name validation
    if !@character.valid? then
      render(:action => :new)
    else
      if @character.save!
        # set the session of new_chara_name to nil, no matter this function is called when create cp or create chara
        # could remove the next line if user is forced to create chara through /character/choose instead of directly 
        # input url with /character/new
        session[:new_chara_name] = nil

        Photo.processWikiImages(params[:summary], params[:images], current_user.id)
      
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
        flash[:error] = "保存失败！"
        render :action => new
      end
    end
  end

  def show
    @character = Character.find_by_id(params[:id])
    @related_cps = Cp.find_all_by_seme_id(@character.id) + Cp.find_all_by_uke_id(@character.id)
    @related_cps.uniq!
  end
  
  def edit
    @character = Character.find_by_id(params[:id])
    @profile_image = Photo.find_by_id(@character.profile_image)
    p "in edit params are"
    p params
  end
  
  def update
    @character = Character.find_by_id(params[:id])
    p "in update params are"
    p params
    @character.assign_attributes(params[:character])
    sanitize(@character.summary)
    if @character.save
      Photo.processWikiImages(params[:character][:summary], params[:images], current_user.id)
      if params[:fromcp] == nil then
        redirect_to @character
      else
        redirect_to cp_path(params[:fromcp])
      end
    else
      render 'edit'
    end
  end

  def choose 
    session[:seme] = nil
    session[:uke] = nil
    session[:new_chara_name] = nil
  end
  
  def search
    if params[:chara] != ""
      params[:chara].strip!
      session[:new_chara_name] = params[:chara]
      @chara = Character.search(params[:chara])
    else
      flash[:error] = "请填写创建角色姓名！"
      redirect_to(:controller => :characters, :action => :choose)
    end
  end
  
  def redirect_to_character_info_or_new_character
    if params[:new_chara] == "nil"
      redirect_to :controller => :characters, :action => :new
    else
      redirect_to :controller => :characters, :action => :show, :id => params[:new_chara]
    end
  end
end










