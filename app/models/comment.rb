class Comment < ApplicationRecord
  belongs_to :pin
  has_many :likes, as: :likeable

  has_many :replies, class_name: "Comment", foreign_key: "comment_id", dependent: :destroy
  belongs_to :comment, optional: true

  default_scope { order(created_at: "DESC") }
  scope :no_replies, -> { where(comment_id: nil) }

  after_update_commit { current_user ? broadcast_append_to("comments") : nil }
  # after_create_commit { broadcast_prepend_to("comments") }
end
