class Guest < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum :access, { attending: 0, invited: 1 }
end
