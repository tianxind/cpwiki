class CreateDraftCps < ActiveRecord::Migration
  def change
    create_table :draft_cps do |t|
    	t.integer :user_id
    	t.integer :cp_id
      t.integer :seme_id, :null => false
      t.integer :uke_id, :null => false
      t.integer :category
      t.string :acronym
      t.text :summary
      t.text :wiki_content
      t.datetime :updated_at
    end
  end
end
