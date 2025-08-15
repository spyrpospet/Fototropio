class Item < ApplicationRecord
  translates :title
  globalize_accessors locales: I18n.available_locales, attributes: %i[title]
  globalize_validations

  # multilanguage validations
  validates :title, presence: true

  validate :validates_globalized_attributes

  acts_as_paranoid

  # associations
  has_one_attached :image
  belongs_to :option, touch: true
  has_many :options_products_item, dependent: :destroy

  # scopes
  scope :common,    -> { order(sort_order: :asc) }
  scope :published, -> { common.where(status: true) }
end
