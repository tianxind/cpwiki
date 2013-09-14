#!/bin/env ruby
# encoding: utf-8

class DraftCharactersController < ApplicationController
  before_filter :authenticate_user!

  def new
    @draft_character = DraftCharacter.new
  end
  
  def create
    #@draft_character = DraftCharacter.new(params[:character])
    p "in draft show params"
    p params

    @draft_character = DraftCharacter.new(:user_id => current_user.id,
                                          :character_id => params[:character_id],
                                          :name => params[:name],
                                          :nickname => params[:nickname],
                                          :sex => params[:sex],
                                          :birth_date => params[:birth_date],
                                          :horoscope => params[:horoscope],
                                          :blood_type => params[:blood_type],
                                          :hair => params[:hair],
                                          :eye => params[:eye],
                                          :height => params[:height],
                                          :weight => params[:weight],
                                          :occupation => params[:occupation],
                                          :work => params[:work],
                                          :updated_at => params[:create_time],
                                          :summary => params[:summary])
    if @draft_character.save!
      p ">>>>>>>> draft save success"
    else
      p ">>>>>>>> draft save failed"
    end
  end
  
  def edit
    @draft_character = DraftCharacter.find_by_id(params[:id])
    @profile_image = Photo.find_by_id(@draft_character.profile_image)
    p "in edit draft chara params are"
    p params
  end
  
  def update
    @character = Character.find_by_id(params[:id])
    p "in update params are"
    p params
    if @character.update_attributes(params[:character])
      if params[:fromcp] == nil then
        redirect_to @character
      else
        redirect_to cp_path(params[:fromcp])
      end
    else
      render 'edit'
    end
  end

end










