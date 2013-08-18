class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
    	t.integer :cp_id
    	t.integer :user_id
    end
  end
end
