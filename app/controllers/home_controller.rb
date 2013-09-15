class HomeController < ApplicationController
  def index
  	session[:seme] = nil
  	session[:uke] = nil
  	session[:new_chara_name] = nil

    @newest = Cp.
  end

  def search
  	@characters = Character.search(params[:query])
  	@cps = Cp.search_by_acronym(params[:query]) 
  end

  def search_by_seme_uke
    @cps = Cp.search_by_seme_uke(params[:seme], params[:uke])
  end
end