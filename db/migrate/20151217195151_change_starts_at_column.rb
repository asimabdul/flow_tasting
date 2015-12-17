class ChangeStartsAtColumn < ActiveRecord::Migration
  def change
    remove_column :events, :starts_at
    add_column :events, :event_date, :date
    add_column :events, :event_time, :time
  end
end
