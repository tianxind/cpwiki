# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
    makoto = Character.create(:name => "Makoto", 
                           :nickname => "MakoChan",
                           :sex => true)
    #makoto.save(:validate => false)
    haruka = Character.create(:name => "Haruka", 
                           :nickname => "HaruChan",
                           :sex => true)
    #haruka.save(:validate => false)
    nagisa = Character.create(:name => "Nagisa", 
                           :nickname => "NagiChan",
                           :sex => true)
    #nagisa.save(:validate => false) 
    rin = Character.create(:name => "Rin", 
                        :nickname => "RinChan",
                        :sex => true)
    #rin.save(:validate => false) 

    # Create initial users
    
    # Create initial cps.
    makoHaru = Cp.create(:creator_id => 1, 
                      :character1_id => 1,
                      :character2_id => 2,
                      :summary => "kain's favourite")
    #makoHaru.save(:validate => false)
    rinHaru = Cp.create(:creator_id => 1, 
                     :character1_id => 4,
                     :character2_id => 2)
    #rinHaru.save(:validate => false)

    # Create initila relation
    makoHaruRelation = Relation.create(:cp_id => 1,
                                    :acronym => "makoHaru",
                                    :intro => "moemoe",
                                    :relation_type => 1)
    #makoHaruRelation.save(:validate => false)
    rinHaruRelation = Relation.create(:cp_id => 1,
                                   :acronym => "rinHaru",
                                   :intro => "moe",
                                   :relation_type => 1)
    #rinHaruRelation.save(:validate => false)
