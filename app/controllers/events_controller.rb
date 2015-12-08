class EventsController < ApplicationController

  def new
    @event = Event.new
    @tasting_package_id = params[:tasting_package_id]
    @host_user_id = params[:host_user_id]
  end

  def index
    @events = Event.hosted_by(current_guest.id)
  end

  def create
    event = Event.create(event_params)
    Guest.process_invites(params[:invite_emails].split(", "), event) if event
    redirect_to event_url(event.id)
  end

  #TODO: Need to show event only if created by current user
  def show
    @event = Event.find(params[:id])
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
      redirect_to :index
    end
    
  end

  def update
    event = Event.find(params[:id])
    event.update_attributes(event_params)
    Guest.process_invites(params[:invite_emails].split(", "), event) if params[:invite_emails].present?
    flash[:success] = "The event has been updated"
    redirect_to event_url(params[:id])
  end

  def event_params
    params[:event].permit(:name, :description, :starts_at, :ends_at, :venue, :tasting_package_id, :host_user_id)
  end
end