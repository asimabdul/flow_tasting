class TastingPackage < ActiveRecord::Base
  has_many :wine_packages, class_name: "WinePackage"
  has_many :wines, through: :wine_packages, dependent: :destroy

  TASTING_CODES = ("A".."Z").to_a

  def add_wines(wine_ids)
    self.wines.clear #clear to ensure no bad data
    wine_ids.uniq.each_with_index do |wine_id, index|
      begin
        wine = Wine.find(wine_id)
        wine_package = WinePackage.new
        wine_package.wine_id = wine.id
        wine_package.tasting_package_id = self.id
        wine_package.wine_tasting_code = TASTING_CODES[index]
        wine_package.save!
      rescue
        next
      end
    end
  end

  def wine_selections
    wines.collect {|wine| [wine.name, wine.id]}
  end

end