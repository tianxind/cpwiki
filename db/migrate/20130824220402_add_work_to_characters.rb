class AddWorkToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :work, :string
  end
end
