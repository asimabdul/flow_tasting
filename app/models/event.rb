class Event < ActiveRecord::Base
  include AASM

  belongs_to :host, foreign_key: :host_user_id, class_name: "User"
  belongs_to :tasting_package
  has_many :guests, dependent: :destroy
  has_many :scorecards

  before_create :generate_event_key
  after_create :send_email_notification

  scope :hosted_by, ->(user_id) {where("host_user_id = ?", user_id)}

  aasm column: :state do
    state :unstarted, initial: true
    state :started
    state :completed

    event :start_event do
      transitions to: :started, from: [:unstarted]
    end

    event :finish_event do
      transitions to: :completed, from: [:started]
    end
  end

  def final_scores
    Scorecard.where(event_id: self.id)
             .select("sum(rank) as wine_rank, wine_id")
             .group(:wine_id)
             .order("wine_rank")
  end

  private
  def generate_event_key
    self[:event_key] = rand(36**8).to_s(36)
  end

  def send_email_notification
    ApplicationMailer.new_event_notification(self).deliver_later
  end
end