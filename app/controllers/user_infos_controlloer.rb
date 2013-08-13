class UserInfosController < ApplicationController
  before_filter :authenticate_user!

  def new
    @user = User.new
  end
  
  def show
    @user = User.find_by_id(current_user.id)
    p "user info is "
    p @user

    @cp_entries = Cp.find_all_by_user_id(@user.id)
    p "all entries created by user is"
    p @cp_entries
  end
end