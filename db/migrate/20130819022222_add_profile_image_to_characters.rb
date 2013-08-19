class AddProfileImageToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :profile_image, :integer
  end
end
