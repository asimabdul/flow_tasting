class RemoveColFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :ends_at
  end
end
