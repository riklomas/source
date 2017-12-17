class User < ApplicationRecord
  
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :stripe_token, presence: true
  validates :subscription_plan, inclusion: { in: ["basic", "pro"] }
  
  has_secure_password
  
  def save_and_subscribe
    # check if the user is valid
    # check the stripe token
    # if everything is okay, make a stripe customer
    # make that stripe customer added to the plan they picked
    
    if self.valid?
      
      # create a stripe customer
      customer = Stripe::Customer.create(source: self.stripe_token, description: self.email)
      
      # make a subscription on stripe
      subscription = Stripe::Subscription.create(
        customer: customer.id, 
        items: [
          { plan: self.subscription_plan }
        ]
      )
      
      # save the customer id to the database
      self.stripe_customer = customer.id
      
      # save the subscription id to the database
      self.stripe_subscription = subscription.id
      
      # save everything
      self.save      
    else
      false
    end
    
  rescue Stripe::CardError => e
    @message = e.json_body[:error][:message]
    
    self.errors.add(:stripe_token, @message)
    
    false
  end  
  
  def update_with_stripe(form_params)
    # update the model with form_params
    # check if it's valid
    # if it's valid, update stripe
    # then update the database    
    self.assign_attributes(form_params)
    
    if self.valid?
      # get the subscription from stripe
      subscription = Stripe::Subscription.retrieve(self.stripe_subscription)
      
      # get the first item from the stripe subscription
      item_id = subscription.items.data[0].id
      
      # make our new items list
      items = [
        { id: item_id, plan: self.subscription_plan }
      ]
      
      # update our subscription with the new items
      subscription.items = items
      
      # save the subscription to stripe
      subscription.save
      
      # save our data to the database
      self.save      
    else
      false
    end
  end
  
  def destroy_and_unsubscribe
    # get the subscription from stripe
    subscription = Stripe::Subscription.retrieve(self.stripe_subscription)
    
    # delete that subscription
    subscription.delete
    
    # remove the user completely
    self.destroy    
  end
  
  
end





