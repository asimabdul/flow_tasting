module Admin
  class EventsController < ApplicationController
    before_filter :authenticate_user!
    before_filter :check_admin_status

    def index
      @events = Event.includes(:host, :tasting_package)
    end

    def show
      @event = Event.find(params[:id])
    rescue
      flash[:error] = "The event could not be found"
      redirect_to admin_events_url
    end

  end
end