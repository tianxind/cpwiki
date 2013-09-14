#!/bin/env ruby
# encoding: utf-8
class DraftCp < ActiveRecord::Base
	belongs_to :user

	attr_accessible :user_id, :cp_id, :category, :summary, :wiki_content, :seme_id, :uke_id, :acronym, :updated_at
end
