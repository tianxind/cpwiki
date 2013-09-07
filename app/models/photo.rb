#!/bin/env ruby
# encoding: utf-8
class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :tags
  
  attr_accessible :filename, :user_id, :date_time
  validates :filename, :presence => { :message => "不能为空！" }

  HUMANIZED_ATTRIBUTES = {
    :filename => "文件名"
  }
end
