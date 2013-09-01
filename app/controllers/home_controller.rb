class HomeController < ApplicationController
  def index
  	session[:seme] = nil
  	session[:uke] = nil
  	session[:new_chara_name] = nil
  end

  def search
  	# Implement logic to search by CP/character or seme/uke
  	characters = Character.search(params[:query])
  	cps = CP.search_by_acronym(params[:query]) 
  end
end