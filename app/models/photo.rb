class Photo < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible :filename, :user_id, :date_time
  validates :filename, :presence => true
end
