class Cp < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :creator, :class_name => "User"
  # belongs_to :seme_id, :class_name => "Character"
  # belongs_to :uke_id, :class_name => "Character"
  
  has_many :comments

  attr_accessible :category, :summary, :wiki_content, :seme_id, :uke_id, :creator_id, :created_at, :acronym
end
