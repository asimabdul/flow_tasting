class Guest < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :event

  before_create :generate_invite_key
  after_create :send_email_notification

  aasm column: :rsvp_state do
    state :maybe, initial: true
    state :going
    state :not_going
  end

  def self.process_invites(emails, event)
    emails.each do |email|
      email = email.strip
      next if !valid_email?(email)
      user = User.find_or_initialize_by(email: email)
      user.save(validate: false) if user.new_record?
      guest = Guest.find_or_create_by(user: user, event: event) #find_or_create is used to prevent duplicate invites
    end
  end

  def self.valid_email?(email)
    result = email.match(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)
    if result
      return true
    else
      return false
    end
  end

  private
  def send_email_notification
    ApplicationMailer.invite_notification(self).deliver_later
  end

  def generate_invite_key
    self[:invite_key] = rand(36**8).to_s(36)
  end

end