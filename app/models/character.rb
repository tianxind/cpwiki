#!/bin/env ruby
# encoding: utf-8
class Character < ActiveRecord::Base
  has_many :cps
  attr_accessible :name, :nickname, :sex, :age_when_first_appear, :birth_date,
  :hair, :eye, :height, :weight, :occupation, :summary, :horoscope, :blood_type, :profile_image

  validates :name, :horoscope, :presence => true
  
  def self.search(q)
    find(:all, :conditions => ['name like ? or nickname like ?', "%#{q}%", "%#{q}%"])
  end

  HOROSCOPE = [['白羊座', 0], ['金牛座', 1], ['双子座', 2], ['巨蟹座', 3],
    ['狮子座', 4], ['处女座', 5], ['天秤座', 6], ['天蝎座', 7], ['射手座', 8],
    ['摩羯座', 9], ['水瓶座', 10], ['双鱼座', 11], ['不明', 12]]
    
  BLOODTYPE = [['A', 0], ['B', 1], ['AB', 2], ['O', 3], ['不明', 4]]
end


