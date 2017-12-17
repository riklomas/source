class AddSubscriptionInfoToUsers < ActiveRecord::Migration[5.1]
  def change
    
    add_column :users, :subscription_plan, :string
    add_column :users, :is_subscription_active, :boolean, default: true
    add_column :users, :stripe_customer, :string
    
  end
end
