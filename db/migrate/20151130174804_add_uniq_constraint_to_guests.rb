class AddUniqConstraintToGuests < ActiveRecord::Migration
  def change
    add_index :guests, :invite_key, unique: true
  end
end
