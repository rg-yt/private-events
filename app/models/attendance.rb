class Attendance < ApplicationRecord
  validates_uniqueness_of :user_id, scope: :event_id
  belongs_to :user
  belongs_to :event
end
