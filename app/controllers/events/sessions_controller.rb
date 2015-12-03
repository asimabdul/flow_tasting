module Events
  class SessionsController < ApplicationController

    def new
      session[:guest_id] = nil
    end

    def create
      guest = authenticate_guest(params[:email], params[:event_key])
      if guest
        session[:guest_id] = guest.id
        redirect_to scores_url
      else
        flash[:error] = "It looks like you haven't been invited for the event."
        redirect_to new_events_session_url
      end
    end

    def destroy
      session[:guest_id] = nil
      redirect_to new_events_session_url
    end

  end
end