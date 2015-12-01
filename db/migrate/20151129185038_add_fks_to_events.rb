class AddFksToEvents < ActiveRecord::Migration
  def change
    add_foreign_key :events, :users, column: :host_user_id
    add_foreign_key :events, :tasting_packages
  end
end
