class HomeController < ApplicationController
  def index
  	session[:seme] = nil
  	session[:uke] = nil
  end
end