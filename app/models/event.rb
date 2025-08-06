class Event < ApplicationRecord
  validates :location, presence: true
  validates :date, presence: true

  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  has_many :guests
  has_many :attendees, through: :guests, source: :user
end
