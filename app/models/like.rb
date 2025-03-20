class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  validates :user, uniqueness: { scope: [ :likeable_type, :likeable_id ] }

  # after_create_commit { broadcast_replace_to "like_pin_#{id}" }
  # after_destroy_commit { broadcast_replace_to "like_pin_#{id}" }

  after_create_commit { broadcast_replace_to("pins_likes", target: "like_#{self.likeable_type.downcase}_#{self.likeable_id}_counter", partial: "likes/counter", locals: { likeable: self.likeable }) }
  after_destroy_commit { broadcast_replace_to("pins_likes", target: "like_#{self.likeable_type.downcase}_#{self.likeable_id}_counter", partial: "likes/counter", locals: { likeable: self.likeable }) }

  # after_create_commit { current_user ? broadcast_replace_to("like_pin_#{id}") : nil }
end
