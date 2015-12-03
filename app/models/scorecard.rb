class Scorecard < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  belongs_to :wine


  def self.create_scorecard(params)
    scorecard = Scorecard.find_or_initialize_by(wine_id: params[:wine_id], event_id: params[:event_id], user_id: params[:user_id])
    scorecard.update_attributes(params)
    scorecard
  end

end