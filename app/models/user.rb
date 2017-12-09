class User < ApplicationRecord
  
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  
  has_secure_password
  
end
