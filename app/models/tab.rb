class Tab < ApplicationRecord
  translates :title, :description
  globalize_accessors locales: I18n.available_locales, attributes: %i[title description]
  globalize_validations

  # multilanguage validations
  validates :title, presence: true

  validate :validates_globalized_attributes

  # associations
  belongs_to :product
end
