class Like < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :cp
  
  attr_accessible :cp_id, :user_id
end
