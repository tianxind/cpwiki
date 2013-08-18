class Photo < ActiveRecord::Base
  belongs_to :user
  
  validates :filename, :presence => true
end
