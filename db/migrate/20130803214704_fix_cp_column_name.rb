class FixCpColumnName < ActiveRecord::Migration
  def up
    rename_column :cps, :character1_id, :character1
    rename_column :cps, :character2_id, :character2
  end

  def down
    rename_column :cps, :character1, :character1_id
    rename_column :cps, :character2, :character2_id
  end
end
