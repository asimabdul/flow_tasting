class AddNotifiedToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :notified, :boolean, default: false
  end
end
