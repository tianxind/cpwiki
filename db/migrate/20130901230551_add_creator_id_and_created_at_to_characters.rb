class AddCreatorIdAndCreatedAtToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :creator_id, :integer
    add_column :characters, :created_at, :datetime
  end
end
