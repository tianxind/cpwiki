#!/bin/env ruby
# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
    makoto = Character.create(:name => "Makoto", 
                              :nickname => "MakoChan",
                              :sex => "小天使",
                              :birth_date =>"19891022",
                              :horoscope => 9,
                              :blood_type => "A",
                              :hair => "Brown")
    #makoto.save(:validate => false)
    haruka = Character.create(:name => "Haruka", 
                           :nickname => "haruChan",
                           :sex => "男",
                           :horoscope => 4)
    #haruka.save(:validate => false)
    nagisa = Character.create(:name => "Nagisa", 
                           :nickname => "NagiChan",
                           :sex => "男",
                           :horoscope => 3)
    #nagisa.save(:validate => false) 
    rin = Character.create(:name => "Rin", 
                           :nickname => "RinChan",
                           :sex => "男",
                           :horoscope => 7)
    #rin.save(:validate => false) 
    ren = Character.create(:name => "Ren",
                           :nickname => "RenChan",
                           :sex => "男",
                           :horoscope => 10)

    # Create initial users
    
    # Create initial cps.
    makoHaru = Cp.create(:creator_id => 1, 
                      :seme_id => 1,
                      :uke_id => 2,
                      :acronym => "makoHaru",
                      :summary => "kain's favourite")
    #makoHaru.save(:validate => false)
    rinHaru = Cp.create(:creator_id => 1, 
                     :seme_id => 4,
                     :uke_id => 2)
    #rinHaru.save(:validate => false)'
    nagiRen = Cp.create(:creator_id => 2,
                        :seme_id => 3,
                        :uke_id => 5,
                        :summary => "moeru!!!!")

    # kain = User.create(:username => "Kain",
    # 									 :email => "kainqiu@gmail.com",
    # 									 :password => "qq1022",
    # 									 :password => "qq1022")

    # sandra = User.create(:username => "Sandra",
    # 										 :email => "daitianxin@gmail.com",
    # 										 :password => "12345678",
    # 										 :password => "12345678")














