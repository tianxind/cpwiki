class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
    	t.integer :pos_x
    	t.integer :pos_y
    	t.string :comment
    	t.integer :user_id
    	t.integer :photo_id
    	t.datetime :created_at
    end
  end
end
