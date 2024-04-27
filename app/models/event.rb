class Event < ApplicationRecord
  validates :date, presence: true
  belongs_to :creator, class_name: 'User'
  has_many :attendances
  has_many :attendees, through: :attendances, source: :user
end
