class Wine < ActiveRecord::Base

  has_many :wine_packages, class_name: "WinePackage"
  has_many :tasting_packages, through: :wine_packages

  validates_presence_of :name


  def self.wine_selections
    Wine.all.collect {|wine| [wine.name, wine.id]}
  end

  def vintage=(value)
    self[:vintage] = value.to_i
  end

end