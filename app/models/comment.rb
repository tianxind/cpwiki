class Comment < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :cp

  attr_accessible :cp_id, :user_id, :date_time, :comment_text

  validates :comment_text, :presence => true
end
