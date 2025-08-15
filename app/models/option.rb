class Option < ApplicationRecord
  translates :title
  globalize_accessors locales: I18n.available_locales, attributes: %i[title]
  globalize_validations

  # multilanguage validations
  validates :title, presence: true

  validate :validates_globalized_attributes

  acts_as_paranoid

  # associations
  has_many :options_product, dependent: :destroy
  has_many :products, through: :options_product
  has_many :product_items, through: :options_product, source: :items

  has_many :items, dependent: :destroy
  has_many :published_items, -> { published }, class_name: "Item"

  accepts_nested_attributes_for :items, allow_destroy: true

  # validations
  validates :sort_order, presence: true, numericality: { only_integer: true }
  validates :status, inclusion: { in: [true, false] }

  # scopes
  scope :common,    -> { order(sort_order: :asc) }
  scope :published, -> { common.where(status: true) }

  # public methods
  def is_published?
    status
  end
end
