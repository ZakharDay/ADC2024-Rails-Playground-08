class Pin < ApplicationRecord
  has_many :comments
  has_many :likes, as: :likeable
  belongs_to :user
  mount_uploader :pin_image, PinImageUploader
  
  acts_as_taggable_on :tags
  acts_as_taggable_on :categories

  has_rich_text :description

  # default_scope { order(created_at: "DESC") }
end
