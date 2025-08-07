class Event < ApplicationRecord
  validates :location, presence: true
  validates :date, presence: true

  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  has_many :guests, dependent: :destroy
  has_many :attendees, through: :guests, source: :user


  scope :upcoming, -> { where("date >= ?", Date.current) }

  scope :past, -> { where("date < ?", Date.current) }

  def own_event(current_user_ID)
    self.user_id == current_user_ID
  end

  def not_attended?(current_user_ID)
    Guest.find_by(user_id: current_user_ID, event_id: self.id).nil?
  end

  def upcoming_event?
    self.date >= Date.current
  end
end
