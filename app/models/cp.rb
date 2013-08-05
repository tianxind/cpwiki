class Cp < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :creator, :class_name => "User"
  belongs_to :character1, :class_name => "Character"
  belongs_to :character2, :class_name => "Character"
  has_many :relations

  attr_accessible :category, :summary, :wiki_content, :character1, :character2, :creator, :created_at
end
