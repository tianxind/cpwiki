class HomeController < ApplicationController
  def index
  	session[:seme] = nil
  	session[:uke] = nil
  	session[:new_chara_name] = nil
  end
end