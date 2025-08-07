class RemoveUniqueIndexFromGuests < ActiveRecord::Migration[8.0]
  def change
    remove_index :guests, [ :user_id, :event_id ], unique: true
  end
end
