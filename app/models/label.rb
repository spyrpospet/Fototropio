class Label < ApplicationRecord
  before_save :set_sort_order,  if: :new_record?

  translates :title, :description, :meta_title, :meta_description, :slug
  globalize_accessors locales: I18n.available_locales, attributes: %i[title description meta_title meta_description slug]
  globalize_validations

  # multilanguage validations
  validates :title, presence: true

  validate :validates_globalized_attributes

  # constants
  STATUS = { published: true, unpublished: false}

  has_many :products, dependent: :nullify

  # scopes
  scope :common,    -> { order(:sort_order) }
  scope :published, -> { common.where(status: STATUS[:published]) }

  def self.available
    find(4)
  end

  def self.unavailable
    find(5)
  end

  private

  def set_sort_order
    self.sort_order = Label.maximum(:sort_order).to_i + 1
  end
end
