class Pin < ApplicationRecord
  has_many :comments
  has_many :likes, as: :likeable
  mount_uploader :pin_image, PinImageUploader
  
  acts_as_taggable_on :tags
  acts_as_taggable_on :categories

  default_scope { order(created_at: "DESC") }
end
