class ApplicationMailer < ActionMailer::Base
  default from: "noreply@flowtasting.com"
  # layout 'mailer'

  def invite_notification(guest_invite)
    @guest_invite = guest_invite
    recipient = @guest_invite.user.email
    mail to: recipient, subject: "You've been invited!"
  end

  def new_event_notification(event)
    @event = event
    recipient = @event.host.email
    mail to: recipient, subject: "You're event has been created"
  end

end
