class ScoresController < ApplicationController
  
  before_filter :require_guest

  def index
    @wines = WinePackage.wine_list(current_event.tasting_package.id)
    @wine_scorecards = @wines.inject({}) do |list, wine|
      list[wine.id] = Scorecard.where(user: current_guest.user, event: current_event, wine: wine.id).first
      list
    end
  end

  def create
    scorecard = Scorecard.create_scorecard(scorecard_params)
    redirect_to scores_url
  end

  private
  def scorecard_params
    params[:scorecard].permit(:wine_id, :flavor, :body).merge({event_id: current_event.id, user_id: current_guest.user.id})
  end
end