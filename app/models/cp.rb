#!/bin/env ruby
# encoding: utf-8
class Cp < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :creator, :class_name => "User"
  belongs_to :seme, :class_name => "Character"
  belongs_to :uke, :class_name => "Character"
  
  has_many :comments

  validates :seme_id, :uke_id, :creator_id, :presence => { :message => "不能为空！"}  

  attr_accessible :category, :summary, :wiki_content, :seme_id, :uke_id, :creator_id, :created_at, :acronym

  HUMANIZED_ATTRIBUTES = {
    :seme_id => "攻",
    :uke_id => "受",
    :creator_id => "创建者"
  }

  CATEGORY = [['动漫', 0], ['影视', 1], ['游戏', 2], ['小说', 3], ['其他', 4]]

  def self.search_by_acronym(q)
    find(:all, :conditions => ['acronym like ?', "%#{q}%"])
  end

  def self.search_cps_by_chara(name)
    @character = Character.search(name)
    results = []
    @character.each do |chara|
      results = results + Cp.find_all_by_seme_id(chara.id) + Cp.find_all_by_uke_id(chara.id)
    end
    return results
  end

  def self.search_by_seme_uke(seme, uke)
    cps = Cp.joins(:seme).where('characters.name like ?', "%#{seme}%")
    results = []
    for cp in cps
      if cp.uke.name.downcase.index(uke.downcase) != nil
        results.push(cp)
      end
    end
    return results
  end

  # Need to optimize this method when database grows large
  def self.get_newest
    Cp.order("id desc", :limit => 10)
  end

  def self.get_hottest
    results = Like.select("cp_id, count(*) as cnt").group("cp_id").order("cnt desc", :limit => 10)
    hottest = Array.new
    for like in results
      hottest.push(Cp.find_by_id(like.cp_id))
    end
    puts "<<<<<<<<<<<<<<<<<<<<<<<"
    puts hottest
    return hottest
  end
end
