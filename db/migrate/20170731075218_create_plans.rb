class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.string :name
      t.string :stripe_id
      t.float :price
      t.string :interval
      t.text :features
      t.boolean :highlight
      t.integer :display_order
      t.string :plan_type
      t.integer :lower_limit
      t.integer :upper_limit

      t.timestamps
    end
  end
end
