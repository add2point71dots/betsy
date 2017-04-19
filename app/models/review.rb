class Review < ApplicationRecord
  belongs_to :product
  validates :rating, presence: true, inclusion: { in: 1..5 }
end
