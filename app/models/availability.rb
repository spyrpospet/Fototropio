class Availability < ApplicationRecord
  translates :title
  globalize_accessors locales: I18n.available_locales, attributes: %i[title]
  globalize_validations

  # multilanguage validations
  validates :title, presence: true

  validate :validates_globalized_attributes

  # actions
  before_create :set_sort_order

  # associations
  has_many :products, dependent: :restrict_with_error

  def self.available
    find(1)
  end

  def self.unavailable
    find(2)
  end

  private

  def set_sort_order
    self.sort_order = Availability.maximum(:sort_order).to_i + 1
  end
end
