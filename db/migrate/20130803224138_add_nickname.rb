class AddNickname < ActiveRecord::Migration
  def up
    add_column :characters, :nickname, :string
  end

  def down
    remove_column :characters, :nickname, :string
  end
end
