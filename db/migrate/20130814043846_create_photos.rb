class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.datetime :date_time
      t.string :filename
    end
  end
end
