module ScoresHelper
  def score_for(event_id, wine_id, guest_id)
    Scorecard.where(event_id: event_id, wine_id: wine_id, user_id: guest_id).first
  end
end