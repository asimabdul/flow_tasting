class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.integer :user_id
      t.integer :event_id
      t.string :rsvp_state
    end
  end
end
