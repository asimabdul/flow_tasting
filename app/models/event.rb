class Event < ActiveRecord::Base
  belongs_to :host, foreign_key: :host_user_id, class_name: "User"
  belongs_to :tasting_package
  has_many :guests, dependent: :destroy

  before_create :generate_event_key

  private
  def generate_event_key
    self[:event_key] = rand(36**8).to_s(36)
  end
end