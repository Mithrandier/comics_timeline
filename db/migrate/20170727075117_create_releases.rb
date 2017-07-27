class CreateReleases < ActiveRecord::Migration[5.0]
  def change
    create_table :releases do |t|
      t.timestamp :released_at, null: false
      t.timestamps
    end

    add_index :releases, :released_at, unique: true
  end
end
