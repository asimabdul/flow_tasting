class Scorecard < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  belongs_to :wine

  BODY_SCORE_MAP = { 1 => "Light", 2 => "Medium", 3 => "Full" }
  SWEETNESS_SCORE_MAP = { 1 => "Dry", 2 => "Medium", 3 => "Sweet" }
  ACIDITY_SCORE_MAP = { 1 => "Low", 2 => "Medium", 3 => "High" }
  FINISH_SCORE_MAP = { 1 => "Short", 2 => "Medium", 3 => "Long" }

  def self.create_scorecard(params)
    scorecard = Scorecard.find_or_initialize_by(wine_id: params[:wine_id], event_id: params[:event_id], user_id: params[:user_id])
    scorecard.update_attributes(params)
    scorecard
  end

  def body=(value)
    self[:body] = BODY_SCORE_MAP.fetch(value.to_i, nil)
  end

  def sweetness=(value)
    self[:sweetness] = SWEETNESS_SCORE_MAP.fetch(value.to_i, nil)
  end

  def acidity=(value)
    self[:acidity] = ACIDITY_SCORE_MAP.fetch(value.to_i, nil)
  end

  def finish=(value)
    self[:finish] = FINISH_SCORE_MAP.fetch(value.to_i, nil)
  end

  def body
    BODY_SCORE_MAP.key(self[:body])
  end

  def sweetness
    SWEETNESS_SCORE_MAP.key(self[:sweetness])
  end

  def acidity
    ACIDITY_SCORE_MAP.key(self[:acidity])
  end

  def finish
    FINISH_SCORE_MAP.key(self[:finish])
  end

end