class CreateWinesPackages < ActiveRecord::Migration
  def change
    create_table :wine_packages do |t|
      t.integer :wine_id
      t.integer :tasting_package_id
      t.string :wine_tasting_code
      t.timestamps
    end

    add_foreign_key :wine_packages, :wines
    add_foreign_key :wine_packages, :tasting_packages

  end
end
