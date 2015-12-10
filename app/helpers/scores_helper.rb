module ScoresHelper
  def score_for(event_id, wine_id, guest_id)
    Scorecard.where(event_id: event_id, wine_id: wine_id, user_id: guest_id).first
  end

  def group_ranking(event_id, wine_id)
    begin
      event = Event.find(event_id)
      index = event.final_scores.find_index {|score| score.wine_id == wine_id}
      index + 1
    rescue
      nil
    end
  end

end