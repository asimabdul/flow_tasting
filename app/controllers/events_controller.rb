class EventsController < ApplicationController

  before_filter :require_guest, only: [:index, :show, :edit, :update, :control]

  def new
    @event = Event.new
    @tasting_package_id = params[:tasting_package_id]
    @tasting_package = TastingPackage.find(@tasting_package_id)
    @host_user_id = params[:host_user_id]
  end

  def index
    @events = Event.hosted_by(current_guest.id)
  end

  def create
    event = Event.create(event_params)
    Guest.process_invites(params[:invite_emails].split(", "), event) if event
    flash[:success] = "Thank you! Your FlowTasting event has been created, and your guests have been invited. We sent you an email with your Event key. Use it to manage your event and run the Virtual Tasting Room during your tasting."
    redirect_to event_url(event.id)
  end

  #TODO: Need to show event only if created by current user
  def show
    @event = Event.find(params[:id])
  end

  def send_reminder
    event = Event.find(params[:id])
    event.send_reminders
    flash[:success] = "Reminders have been sent to your guests."
    redirect_to event_url(event.id)
  end

  def edit
    event = Event.where(id: params[:id]).includes(guests: :user)
    if current_guest == event.first.host
      @event = event.first
      @invite_emails = []
      event.each do |event_obj|
        event_obj.guests.each {|guest| @invite_emails << guest.user.email }
      end
      @invite_emails = @invite_emails.join(",")
    else
      flash[:error] = "You are not hosting the event and don't have permission to edit"
      redirect_to events_url
    end
    
  end

  def update
    event = Event.find(params[:id])
    event.update_attributes(event_params)
    Guest.process_invites(params[:invite_emails].split(", "), event) if params[:invite_emails].present?
    flash[:success] = "Your FlowTasting event has been updated."
    redirect_to event_url(params[:id])
  end

  def control
    event = Event.find(params[:id])
    if params[:operation] == "start"
      event.start_event!
    elsif params[:operation] == "finish"
      event.finish_event!
    end
    redirect_to scores_url
  end

  private
  def event_params
    params[:event].permit(:name, :description, :event_date, :event_time, :venue, :tasting_package_id, :host_user_id)
  end
end