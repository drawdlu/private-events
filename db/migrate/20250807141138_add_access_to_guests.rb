class AddAccessToGuests < ActiveRecord::Migration[8.0]
  def change
    add_column :guests, :access, :integer, default: 0
  end
end
