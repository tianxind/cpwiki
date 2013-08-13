class Character < ActiveRecord::Base
  has_many :cps
  attr_accessible :name, :nickname, :sex, :age_when_first_appear, :birth_date,
  :hair, :eye, :height, :weight, :occupation, :summary, :horoscope, :blood_type

  validates :name, :presence => true
  
  def self.search(q)
    find(:all, :conditions => ['name like ? or nickname like ?', "%#{q}%", "%#{q}%"])
  end
end
