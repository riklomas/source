class Item < ApplicationRecord
  
  has_many :category_items
  has_many :categories, through: :category_items
  
  validates :title, presence: true
  
  mount_uploader :image, ImageUploader
  
end
