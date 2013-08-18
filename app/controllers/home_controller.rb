class HomeController < ApplicationController
  def index
    @photo = Photo.new
  end
end