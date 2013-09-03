class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.integer :cp_id
    	t.integer :user_id
    	t.text :comment_text
    	t.datetime :date_time
    end
  end
end
