class Restaurant < ApplicationRecord
  has_many :users,dependent: :destroy
  has_many :bookings,dependent: :destroy

  def user
    users.first
  end
end
