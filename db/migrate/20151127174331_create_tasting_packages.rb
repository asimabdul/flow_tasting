class CreateTastingPackages < ActiveRecord::Migration
  def change
    create_table :tasting_packages do |t|
      t.string :name, null: false
      t.decimal :price, precision: 8, scale: 2, null: false
      t.string :state
      t.timestamps
    end
  end
end
