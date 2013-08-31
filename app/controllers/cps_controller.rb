#!/bin/env ruby
# encoding: utf-8
class CpsController < ApplicationController
  before_filter :authenticate_user!, :except => [:search, :show, :redirect_to_cp_or_character]

  def index
  end

  def new
    @photo = Photo.new
    @cp = Cp.new
    @seme = Character.find_by_id(session[:seme])
    @uke = Character.find_by_id(session[:uke])
    p "session id seme, uke are "
    p session[:seme]
    p session[:uke]
  end

  def create
    puts "<<<<<<<<<<<<<<<<What are the params?"
    puts params
    @cp = Cp.new(:category => params[:category], 
                 :summary => params[:summary], 
                 :wiki_content => params[:wiki_content],
                 :seme_id => session[:seme],
                 :uke_id => session[:uke],
                 :creator_id => current_user.id,
                 :acronym => params[:acronym],
                 :created_at => Time.now)
                 
    # see if there are any images we need to delete
    if params[:images] != nil
      Photo.deleteUnusedImages(params[:wiki_content], params[:images])
    end
    
    if @cp.save
      session[:seme] = nil
      session[:uke] = nil
      session[:name1] = nil
      session[:name2] = nil
      redirect_to :controller => :cps, :action => :show, :id => @cp.id
    else
      render :action => :new
    end
  end
  
  def show
    @cp = Cp.find_by_id(params[:id])
    @seme = Character.find_by_id(@cp.seme_id)
    @uke = Character.find_by_id(@cp.uke_id)
    @comment_array = @cp.comments
    if user_signed_in? then 
      @already_liked = Like.where(:user_id => current_user.id, :cp_id =>params[:id]).size
    end
    p "already_liked size is >>>>>>>>"
    p @already_liked
    p "comment array is ->>>>>>"
    p @comment_array
  end

  def edit
    @cp = Cp.find_by_id(params[:id])
  end

  def update
    @cp = Cp.find_by_id(params[:id])
    
    if @cp.update_attributes(params[:cp])
      redirect_to @cp
    else
      render 'edit'
    end
  end

  def choose 
  end
  
  def search
    p "in search params is"
    p params
    # check if input names are null
    if params[:name1] != "" && params[:name2] != ""
      session[:category] = params[:category]
      params[:name1].strip!
      params[:name2].strip!
      session[:name1] = params[:name1]
      session[:name2] = params[:name2]

      p "in seach func session name1 and name 2 are"
      p session[:name1]
      p session[:name2]
      @character1 = Character.search(params[:name1])
      @character2 = Character.search(params[:name2])
    else 
      flash[:error] = "请填写创建角色姓名！"
      redirect_to(:controller => :cps, :action => :choose)
    end
  end
  
  def redirect_to_cp_or_character
    session[:seme] = params[:character1]
    session[:uke] = params[:character2]
    puts "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
    puts "semd_id = #{session[:seme]}"
    puts "uke_id = #{session[:uke]}"
    if session[:seme] != "nil" && session[:uke] != "nil"
      cp = Cp.find(:all, :conditions => {:seme_id => session[:seme], :uke_id => session[:uke]})
      if cp.length > 0
        p "cp length > 0"
        redirect_to :action => :show, :id => cp[0].id
      else
        p "cp not exist"
        redirect_to :action => :new
      end
    else
      p "redirect to chara/new"
      redirect_to :controller => :characters, :action => :new
    end
  end
end

