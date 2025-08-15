class OptionsProduct < ApplicationRecord
  belongs_to :option
  belongs_to :product, touch: true

  has_many :options_products_item, dependent: :destroy
  has_many :items, through: :options_products_item, source: :item

  accepts_nested_attributes_for :options_products_item, allow_destroy: true

  # scopes
  scope :filters,             -> { where(filter: true) }
  scope :characteristics,     -> { where(characteristic: true) }
  scope :not_characteristics, -> { where(characteristic: false) }
end
