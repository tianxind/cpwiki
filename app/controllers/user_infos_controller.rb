class UserInfosController < ApplicationController
  before_filter :authenticate_user!

  def new
    @user = User.new
  end
  
  def index
    @user = User.find_by_id(current_user.id)
    #p "user info is "
    #p @user

    @cp_entries = Cp.find_all_by_creator_id(@user.id)
    #@cp_entries = @user.cps
    #p "all entries created by user is"
    #p @cp_entries

    @user_likes = Like.find_all_by_user_id(@user.id)
    #p "all likes by user is"
    #p @user_likes
  end
end