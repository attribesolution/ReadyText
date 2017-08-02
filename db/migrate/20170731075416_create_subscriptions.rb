class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.string :stripe_id
      t.integer :plan_id
      t.string :last_four
      t.integer :coupon_id
      t.string :card_type
      t.float :current_price
      t.integer :user_id
      t.datetime :expired_at
      t.boolean :in_trial
      t.string :subs_type
      t.string :status
      t.datetime :started_at
      

      t.timestamps
    end
  end
end
