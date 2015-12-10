class RemoveCompletedAndAddStateToEvents < ActiveRecord::Migration
  def change
    remove_column :events, :completed
    add_column :events, :state, :string
  end
end
