class AddCreatorToEvent < ActiveRecord::Migration[6.1]
  def change
    change_table :events do |t|
      add_reference(:events, :creator, foreign_key: { to_table: :users })
    end
  end
end
