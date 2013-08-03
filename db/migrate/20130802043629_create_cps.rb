class CreateCps < ActiveRecord::Migration
  def change
    create_table :cps do |t|
      t.integer :creator, :null => false
      t.datetime, :created_at
      t.integer :character1_id
      t.integer :character2_id
    end
  end
end
