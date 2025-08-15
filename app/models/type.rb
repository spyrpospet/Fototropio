class Type < ApplicationRecord
  translates :title
  globalize_accessors locales: I18n.available_locales, attributes: %i[title]

  # associations
  has_many :pages
end
