class AddUniqConstraintToWinesPackages < ActiveRecord::Migration
  def change
    add_index :wine_packages, [:wine_id, :tasting_package_id, :wine_tasting_code], name: "uniq_package", unique: true
  end
end
