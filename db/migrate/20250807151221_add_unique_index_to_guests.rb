class AddUniqueIndexToGuests < ActiveRecord::Migration[8.0]
  def change
    add_index :guests, [ :user_id, :event_id, :access ], unique: true
  end
end
