class AddColumnsToBookings < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :deleted_at, :datetime
    add_index :bookings, :deleted_at
    add_column :bookings, :status, :integer
    add_column :bookings, :checkin, :boolean,default: false
    add_column :bookings, :sequence_in_progress, :boolean,default: false
    add_column :bookings, :wait_in_minutes, :integer,default: 0
    add_column :bookings, :customer_id, :integer
  end
end
