class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.boolean :sex
      t.integer :age_when_first_appear
      t.date :birth_date
      t.string :hair
      t.string :eye
      t.string :height
      t.string :weight
      t.string :occupation
      t.string :summary
    end
  end
end
