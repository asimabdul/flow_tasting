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
    valid_emails = emails.select {|email| Guest.valid_email?(email) }
    return if valid_emails.empty?
    #Todo: need to handle duplicate email delivery
    # event.guests.delete_all

    event.guests.each do |guest|
      guest_email = guest.user.email
      if valid_emails.include?(guest_email)
        next
      else
        guest.destroy #remove the guest who is not present in the updated list of emails
      end
    end

    valid_emails.each do |email|
      email = email.strip
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

  def send_reminder
    ApplicationMailer.remind_guest(self).deliver_later
  end

  def format_rsvp_state
    case self[:rsvp_state]
    when "going"
      return "Yes"
    when "not_going"
      return "No"
    when "maybe"
      return "No answer"
    else
      return ""
    end
  end

  private
  def send_email_notification
    if !self.notified?
      ApplicationMailer.invite_notification(self).deliver_later
      self.update_attribute(:notified, true)
    end
  end

  def generate_invite_key
    self[:invite_key] = rand(36**8).to_s(36)
  end

end