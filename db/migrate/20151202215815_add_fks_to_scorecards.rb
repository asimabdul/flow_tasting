class AddFksToScorecards < ActiveRecord::Migration
  def change
    add_foreign_key :scorecards, :users
    add_foreign_key :scorecards, :events
    add_foreign_key :scorecards, :wines
  end
end
