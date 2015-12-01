class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :event_key
      t.text :description
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :venue
      t.integer :host_user_id
      t.integer :tasting_package_id
      t.integer :receipt_id
      t.timestamps
    end
  end
end
