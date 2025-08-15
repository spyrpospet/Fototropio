class ItemsProduct < ApplicationRecord
  belongs_to :item
  belongs_to :product

  has_one_attached :image, dependent: :destroy
end
