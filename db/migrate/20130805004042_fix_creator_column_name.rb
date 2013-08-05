class FixCreatorColumnName < ActiveRecord::Migration
  def up
    rename_column :cps, :creator, :creator_id
  end

  def down
    rename_column :cps, :creator_id, :creator
  end
end
