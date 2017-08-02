class AddColumnsTrialToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :trial_ends_at, :datetime
    add_column :users, :in_trial, :boolean,default: true
    add_column :users, :stripe_customer_id, :string
  end
end
