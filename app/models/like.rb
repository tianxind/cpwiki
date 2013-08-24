class Like < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :cp
  
  attr_accessible :cp_id, :user_id

  validates :cp_id, :user_id, :presence => { :message => "不能为空！" }

  HUMANIZED_ATTRIBUTES = {
    :cp_id => "CP",
    :user_id => "用户"
  }
end
