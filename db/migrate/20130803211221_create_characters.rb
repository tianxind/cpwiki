class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
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
    end
  end
end
