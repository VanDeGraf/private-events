class Event < ApplicationRecord
  belongs_to :creator, class_name: "User", inverse_of: :created_events
  has_and_belongs_to_many :attendees,
                          class_name: "User",
                          inverse_of: :attended_events,
                          foreign_key: :attended_event_id,
                          association_foreign_key: :attendee_id,
                          join_table: "attended_events_attendees"

  scope :past, -> { where("date < ?", Date.today) }
  scope :future, -> { where("date >= ?", Date.today) }
end
