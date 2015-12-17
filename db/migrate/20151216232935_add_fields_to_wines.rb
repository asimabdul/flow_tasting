class AddFieldsToWines < ActiveRecord::Migration
  def change
    add_column :wines, :producer, :string
    add_column :wines, :vintage, :integer
  end
end
