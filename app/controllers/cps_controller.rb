class CpsController < ApplicationController
  before_filter :authenticate_user!
  def index
  end

  def new
  	@cp = Cp.new
    @character1 = Character.find_by_id(5)
    @character2 = Character.find_by_id(6)
  end

  def create
  end

end