class AddCharacterColumn < ActiveRecord::Migration
  def up
    add_column :characters, :horoscope, :integer
    add_column :characters, :blood_type, :integer 
  end

  def down
    remove_column :characters, :horoscope, :integer
    remove_column :characters, :blood_type, :integer
  end
end
