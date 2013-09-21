class CreateBugReports < ActiveRecord::Migration
  def change
    create_table :bug_reports do |t|
    	t.integer :user_id
    	t.text :bug_report_text
    	t.datetime :date_time
    end
  end
end
