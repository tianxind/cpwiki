class UserInfosController < ApplicationController
  before_filter :authenticate_user!

  def new
    @user = User.new
  end
  
  def index
    @user = User.find_by_id(current_user.id)

    @cp_entries = Cp.find_all_by_creator_id(@user.id)
    @user_likes = Like.find_all_by_user_id(@user.id)
    @character_entries = Character.find_all_by_creator_id(current_user.id)

  end
end