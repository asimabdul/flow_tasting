class ApplicationMailer < ActionMailer::Base
  default from: "noreply@flowtasting.com"
  # layout 'mailer'

  def invite_notification(guest_invite)
    @guest_invite = guest_invite
    @event = @guest_invite.event
    recipient = @guest_invite.user.email
    host = @guest_invite.event.host
    mail to: recipient, subject: "You’ve been invited to a FlowTasting!", cc: host.email, reply_to: host.email, from: make_sender("noreply@flowtasting.com", host.first_name)
  end

  def new_event_notification(event)
    @event = event
    recipient = @event.host.email
    mail to: recipient, subject: "You're event has been created", from: make_sender("noreply@flowtasting.com", "FlowTasting")
  end

  def make_event_notification(package, user)
    @tasting_package = package
    @user = user
    recipient = @user.email
    mail to: recipient, subject: "Create and manage your FlowTasting Event", from: make_sender("noreply@flowtasting.com", "FlowTasting")
  end

  def remind_guest(guest)
    @guest = guest
    @event = guest.event
    host = @event.host
    recipient = @guest.user.email
    mail to: recipient, subject: "This is a reminder for your event!", reply_to: host.email, from: make_sender("noreply@flowtasting.com", host.first_name)
  end

  private
  def make_sender(email, name)
    address = Mail::Address.new
    address.address = email
    address.display_name = name.titleize if !name.blank?
    address
  end

end
