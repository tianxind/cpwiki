class CreateCps < ActiveRecord::Migration
  def change
    create_table :cps do |t|
      t.integer :creator_id, :null => false
      t.datetime :created_at
      t.integer :seme_id, :null => false
      t.integer :uke_id, :null => false
      t.integer :category
      t.string :acronym
      t.text :summary
      t.text :wiki_content
    end
  end
end
