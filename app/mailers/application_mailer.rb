class ApplicationMailer < ActionMailer::Base
  default from: "noreply@flowtasting.com"
  # layout 'mailer'

  def invite_notification(guest_invite)
    @guest_invite = guest_invite
    @event = @guest_invite.event
    recipient = @guest_invite.user.email
    host_email = @guest_invite.event.host.email
    mail to: recipient, subject: "You’ve been invited to a FlowTasting!", cc: host_email, from: host_email
  end

  def new_event_notification(event)
    @event = event
    recipient = @event.host.email
    mail to: recipient, subject: "You're event has been created"
  end

  def make_event_notification(package, user)
    @tasting_package = package
    @user = user
    recipient = @user.email
    mail to: recipient, subject: "Create and mange your FlowTasting Event"
  end

  def remind_guest(guest)
    @guest = guest
    recipient = @guest.user.email
    mail to: recipient, subject: "This is a reminder for your event!"
  end

end
