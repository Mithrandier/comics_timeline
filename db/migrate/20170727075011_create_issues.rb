class CreateIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :issues do |t|
      t.references :series
      t.references :release, index: true
      t.string :title, null: false
      t.float :issue_number
      t.string :cover
      t.string :details_url

      t.timestamps
    end

    add_index :issues, [:series_id, :issue_number], unique: true
  end
end
