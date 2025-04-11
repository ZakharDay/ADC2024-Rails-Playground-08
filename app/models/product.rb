class Product < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:name, :description]

  has_and_belongs_to_many :carts
end
