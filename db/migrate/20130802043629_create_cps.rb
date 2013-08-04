class CreateCps < ActiveRecord::Migration
  def change
    create_table :cps do |t|
      t.integer :creator, :null => false
      t.datetime :created_at
      t.integer :character1_id, :null => false
      t.integer :character2_id, :null => false
      t.integer :category
      t.text :summary
      t.text :wiki_content
    end
  end
end
