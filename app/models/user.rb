class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable
  has_many :created_events, foreign_key: :creator_id, inverse_of: :creator, class_name: "Event"
  has_and_belongs_to_many :attended_events,
                          class_name: "Event",
                          inverse_of: :attendees,
                          foreign_key: :attendee_id,
                          association_foreign_key: :attended_event_id,
                          join_table: "attended_events_attendees"
end
