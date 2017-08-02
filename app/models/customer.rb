class Customer < ApplicationRecord
  belongs_to :restaurant
  has_many :bookings,dependent: :destroy
  scope :by_phone_and_restaurant , ->(phone,restaurant) {where(restaurant: restaurant,phone: phone)}



  def self.to_csv(customers,options = {})
    header_columns = [
      "Name",
      "Phone",
      "No. of visits",
      "Last visit Time"
    ]

    CSV.generate(options) do |csv|
      csv << header_columns
      customers.each do |customer|
        if customer.bookings.any?
          bookings = customer.bookings
          booking = bookings.last
          row = [
            booking.party_name,
            booking.phone,
            bookings.size,
            booking.booking_time.try(:strftime,"%d/%m/%Y %H:%M %p")
          ]
          csv << row
        end
      end
    end
  end
end
