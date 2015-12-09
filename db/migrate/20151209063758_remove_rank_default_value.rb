class RemoveRankDefaultValue < ActiveRecord::Migration
  def change
    change_column :scorecards, :rank, :integer, default: :nil
  end
end
