class LikesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @like = Like.new
  end

  def create
    p "in like create action"
  	p "params cp_id is" + params[:cp_id].to_s
    # @liked_before = false
    # @already_liked_array = Like.find_all_by_user_id(current_user.id)
    # p "already_liked_array is >>>>>>"
    # p @already_liked_array
    # @already_liked = Cp.new
    # @already_liked_array.each do |liked_cp|
    #   if(liked_cp.cp_id == params[:cp_id])
    #     @liked_before = true
    #     @already_liked = liked_cp
    #   end
    # end

    @already_liked_current_cp = Like.find_by_sql("SELECT * from likes WHERE user_id=" + current_user.id.to_s + " AND cp_id=" + params[:cp_id].to_s)
    p "start>>>>>>"
    p @already_liked_current_cp
    if(@already_liked_current_cp.size != 0)
      # already liked, unlike it      
      p "already liked, remove row >>>>>> "
      @already_liked_current_cp.each do |liked_entry| 
        Like.destroy(liked_entry.id)
      end
      #Like.destroy(@already_liked.id)
    else
      p "not liked before"
      # not liked before, create a new one
      @like = Like.new(:cp_id => params[:cp_id], 
                       :user_id => current_user.id)
      if !@like.save
        p "like not saved!"
      else
        p "like successfully saved!"
      end

    end


   # @like = Like.new(:cp_id => params[:cp_id], 
   #                     :user_id => current_user.id)
   #  if !@like.save
   #    p "like not saved!"
   #  else
   #    p "like successfully saved!"
   #  end

  end
end