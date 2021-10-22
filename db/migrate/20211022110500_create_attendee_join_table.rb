class CreateAttendeeJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :attended_events, :attendees do |t|
      t.index [:attendee_id, :attended_event_id], unique: true, name: "index_attendes"
    end
  end
end
