class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations do |t|
    	t.integer :cp_id
      t.string :acronym
      t.text :intro
      t.integer :relation_type
    end
  end
end
