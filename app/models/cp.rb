class Cp < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user

  has_many :relations

  attr_accessible :category, :summary, :wiki_content, :character1, :character2, :creator, :created_at
end
