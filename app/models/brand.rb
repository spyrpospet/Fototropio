class Brand < ApplicationRecord
  include Brand::Search
  include CustomTools

  has_ancestry
  acts_as_paranoid

  translates :title, :description, :meta_title, :meta_description, :slug
  globalize_accessors locales: I18n.available_locales, attributes: %i[title description meta_title meta_description slug]
  globalize_validations

  # multilanguage validations
  validates :title, presence: true

  STATUSES = { published: true, unpublished: false }.freeze

  before_save :set_sort_order,  if: :new_record?
  before_save :set_slug,        if: :new_record?
  before_save :set_handle,      if: :new_record?
  before_save :set_meta_title

  # associations
  has_one_attached :image do |attachable|
    attachable.variant :admin_list, resize_to_limit: [150, 150], preprocessed: true
    attachable.variant :admin, resize_to_limit: [420,200], preprocessed: true
    attachable.variant :home, resize_and_pad: [163, 122, gravity: :centre, background: [255, 255, 255]], preprocessed: true
    attachable.variant :brand, resize_to_limit: [470, 200], preprocessed: true
  end

  has_many :products

  scope :common,        -> { order(sort_order: :asc) }
  scope :collections,   -> { common.where(collection: true) }
  scope :published,     -> { common.where(status: true) }

  private

  def set_slug
    I18n.available_locales.each do |locale|

      next if self.send("title_#{locale}").blank?

      slug = self.convert_cas(self.send("title_#{locale}"))

      # we check if slug already exists and if yes we add -1, -2, -3, etc.
      while Brand.joins(:translations).where("brand_translations.slug = ? AND brand_translations.locale = ?", slug, locale.to_s).exists?
        slug = slug + "-#{Brand.joins(:translations).where("brand_translations.slug = ? AND brand_translations.locale = ?", slug, locale.to_s).count}"
      end

      self.send("slug_#{locale}=", slug).gsub("_#{locale}", '')
    end
  end

  def set_meta_title
    I18n.available_locales.each do |locale|
      self.send("meta_title_#{locale}=", self.send("title_#{locale}"))
    end
  end

  def set_handle
    self.handle = convert_cas(self.send("title_#{I18n.default_locale}").downcase)
  end

  def set_sort_order
    self.sort_order = Brand.maximum(:sort_order).to_i + 1
  end
end
