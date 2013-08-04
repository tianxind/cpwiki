class Relation < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :cp

  attr_accessible :cp_id, :acronym, :intro, :type
end
