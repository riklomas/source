class AddStripeSubscriptionToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :stripe_subscription, :string
  end
end
