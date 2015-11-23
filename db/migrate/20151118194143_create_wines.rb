class CreateWines < ActiveRecord::Migration
  def change
    create_table :wines do |t|
      t.string :name, null: false
      t.string :region
      t.string :wine_type #this has been named wine_type instead of type so that it doesn't conflict with Rails STI
      t.text :description
      t.text :fun_facts
      t.timestamps
    end

    add_index :wines, :name

  end
end
