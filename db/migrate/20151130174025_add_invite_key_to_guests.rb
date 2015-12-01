class AddInviteKeyToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :invite_key, :string, null: false
  end
end
