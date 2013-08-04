class CharactersController < ApplicationController
  def new
    @character = Character.new
  end
  
  def create
    @character = Character.new(params[:character])
    if @character.save!
      redirect_to :controller => :cps, :action => :new
    else
      render :action => new
    end
  end
end