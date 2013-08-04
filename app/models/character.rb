class Character < ActiveRecord::Base
  attr_accessible :name, :nickname, :sex, :age_when_first_appear, :birth_date,
  :hair, :eye, :height, :weight, :occupation, :summary, :horoscope, :blood_type

  validates :name, :presence => true
end
