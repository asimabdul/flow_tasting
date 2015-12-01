class GuestsController < ApplicationController
  def rsvp
    @guest_invite = Guest.where(invite_key: params[:invite_key]).first
  end

  def update
    @guest_invite = Guest.find_by_invite_key(params[:invite_key])
    @guest_invite.update_attribute(:rsvp_state, params[:rsvp_choice])
    flash[:success] = "You're RSVP has been registered."
    redirect_to register_rsvp_url(invite_key: params[:invite_key])
  end
end