class AddFksToGuests < ActiveRecord::Migration
  def change
    add_foreign_key :guests, :users
    add_foreign_key :guests, :events
  end
end
