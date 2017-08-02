class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :coupon,optional: true
  belongs_to :plan

  scope :trial, -> {where(subs_type: Yetting.subscription_types["trial"])}
  scope :walkin, -> {where(subs_type: Yetting.subscription_types["walkin"])}
  scope :marketing, -> {where(subs_type: Yetting.subscription_types["marketing"])}


  def expired?
    self.expired_at.to_i < Time.now.to_i
  end

end
