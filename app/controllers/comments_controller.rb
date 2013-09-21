#!/bin/env ruby
# encoding: utf-8
class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @comment = Comment.new
  end
  
  def create
    create_time = DateTime.parse(params[:create_time])
    @comment = Comment.new(:cp_id => params[:id],
                           :user_id => current_user.id,
                           :comment_text => params[:comment_text],
                           :date_time => create_time)
    if !@comment.save
      render
    else 
      redirect_to :controller => :cps, :action => :show, :id => params[:id]
    end
  end
end













