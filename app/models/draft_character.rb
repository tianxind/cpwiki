#!/bin/env ruby
# encoding: utf-8
class DraftCharacter < ActiveRecord::Base
  belongs_to :user

  attr_accessible :user_id, :character_id, :name, :nickname, :work, :sex, :age_when_first_appear, :birth_date,
  :hair, :eye, :height, :weight, :occupation, :summary, :horoscope, :blood_type, :profile_image, :updated_at

  HOROSCOPE = [['白羊座', 0], ['金牛座', 1], ['双子座', 2], ['巨蟹座', 3],
    ['狮子座', 4], ['处女座', 5], ['天秤座', 6], ['天蝎座', 7], ['射手座', 8],
    ['摩羯座', 9], ['水瓶座', 10], ['双鱼座', 11], ['不明', 12]]
    
  BLOODTYPE = [['A', 0], ['B', 1], ['AB', 2], ['O', 3], ['不明', 4]]

  HUMANIZED_ATTRIBUTES = {
    :name => "角色姓名",
    :horoscope => "星座",
    :blood_type => "血型"
  }

  def self.human_attribute_name(attr, options={})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
end
