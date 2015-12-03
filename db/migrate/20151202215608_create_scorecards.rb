class CreateScorecards < ActiveRecord::Migration
  def change
    create_table :scorecards do |t|
      t.integer :flavor, default: 0
      t.integer :body, default: 0
      t.integer :rank, default: 0
      t.integer :user_id
      t.integer :event_id
      t.integer :wine_id
      t.timestamps
    end
  end
end
