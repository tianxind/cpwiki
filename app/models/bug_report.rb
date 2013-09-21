#!/bin/env ruby
# encoding: utf-8
class BugReport < ActiveRecord::Base
  belongs_to :user

  attr_accessible :user_id, :date_time, :bug_report_text

  validates :bug_report_text, :presence => { :message => "不能为空！" }

  HUMANIZED_ATTRIBUTES = {
    :bug_report_text => "报错"
  }
end
