class Event < ApplicationRecord
  default_scope { order(date: :asc) }
  validates :date, presence: true
  belongs_to :creator, class_name: 'User'
  has_many :attendances
  has_many :attendees, through: :attendances, source: :user

  scope :past, -> { where('date <= ?', DateTime.current.to_date) }
  scope :future, -> { where('date > ?', DateTime.current.to_date) }

  # def self.past
  #   where('date <= ?', DateTime.current.to_date)
  # end

  # def self.future
  #   where('date > ?', DateTime.current.to_date)
  # end
end
