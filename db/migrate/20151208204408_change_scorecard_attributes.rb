class ChangeScorecardAttributes < ActiveRecord::Migration
  def change
    remove_column :scorecards, :flavor
    change_column :scorecards, :body, :string
    add_column :scorecards, :sweetness, :string
    add_column :scorecards, :acidity, :string
    add_column :scorecards, :finish, :string
    add_column :scorecards, :comments, :text
  end
end
