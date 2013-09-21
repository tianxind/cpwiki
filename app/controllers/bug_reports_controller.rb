#!/bin/env ruby
# encoding: utf-8
class BugReportsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @bug_report = BugReport.new
  end
  
  def create
    p ">>> bug report is "
    p params[:comment_text]
    create_time = DateTime.parse(params[:create_time])
    @bug_report = BugReport.new(:user_id => current_user.id,
                                :bug_report_text => params[:comment_text],
                                :date_time => create_time)
    if !@bug_report.save
      render
    else 
      redirect_to :controller => :bug_reports, :action => :index
    end
  end

  def index
    @bug_reports = BugReport.all
  end
end













