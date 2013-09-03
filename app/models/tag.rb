class Tag < ActiveRecord::Base
  attr_accessible :pos_x, :pos_y, :comment, :user_id, :photo_id, :created_at

  belongs_to :user
  belongs_to :photo
end
