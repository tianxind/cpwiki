class CreateDraftCharacters < ActiveRecord::Migration
  def change
    create_table :draft_characters do |t|
    	t.integer :user_id
    	t.integer :character_id
    	t.string :name
      t.string :nickname
      t.string :sex
      t.integer :age_when_first_appear
      t.date :birth_date
      t.integer :horoscope
      t.integer :blood_type
      t.string :hair
      t.string :eye
      t.string :height
      t.string :weight
      t.string :occupation
      t.text :summary
      t.string :work
      t.integer :profile_image
      t.datetime :updated_at
    end
  end
end
