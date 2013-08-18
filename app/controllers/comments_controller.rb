class CommentsController < ApplicationController
   before_filter :authenticate_user!
   # skip_before_filter :verify_authenticity_token, :only => [:create]

  def new
    @comment = Comment.new
  end
  
  def create
    p ">>>>>>>>> in comment create"
    p "new comment is "
    p params[:comment_text]
    p "in create comment id is >>>>>>>>>>"
    p params[:id]
    p "current user id is >>>>>>>>"
    p current_user.id.to_s
    p "date time from ajax is >>>>>>>>>"
    p params[:create_time]
    create_time = DateTime.parse(params[:create_time])
    @comment = Comment.new(:cp_id => params[:id],
                           :user_id => current_user.id,
                           :comment_text => params[:comment_text],
                           :date_time => create_time)
    if !@comment.save
      p ">>>>>>>>> comment saving failed"
    else 
      p ">>>>>>>>> save succeed!"
      redirect_to :controller => :cps, :action => :show, :id => params[:id]
    end
  end
end













