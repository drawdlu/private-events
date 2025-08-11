class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :events, dependent: :destroy
  has_many :guests, dependent: :destroy
  has_many :attended_events, -> { where("guests.access = ?", 0) },
             through: :guests, source: :event

  has_many :invited_events, -> { where("guests.access = ?", 1) },
              through: :guests, source: :event

  def invited_events_not_attended
    @events_invited = self.invited_events.upcoming
    @events_attending = self.attended_events.upcoming

    @invited_events_not_attended = @events_invited - @events_attending

    Event.where(id: @invited_events_not_attended.map(&:id))
  end
end
