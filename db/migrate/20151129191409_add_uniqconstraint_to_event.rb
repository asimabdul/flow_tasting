class AddUniqconstraintToEvent < ActiveRecord::Migration
  def change
    add_index :events, :event_key, unique: true
  end
end
