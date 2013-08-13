class CharactersController < ApplicationController
  def new
    @character = Character.new
  end
  
  def create
    @character = Character.new(params[:character])
    if @character.save!
      if session[:id1] == "nil"
        session[:id1] = @character.id 
      elsif session[:id2] == "nil"
        session[:id2] = @character.id
      end
      if session[:id2] != "nil"
        redirect_to :controller => :cps, :action => :new
      else
        redirect_to :controller => :characters, :action => :new
      end
    else
      render :action => new
    end
  end
end