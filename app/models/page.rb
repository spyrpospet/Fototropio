class Page < ApplicationRecord
  include Page::Search
  include CustomTools

  has_ancestry

  translates :title, :description, :left_column, :right_column, :meta_title, :meta_description, :slug
  globalize_accessors locales: I18n.available_locales, attributes: %i[title description left_column right_column meta_title meta_description slug]
  globalize_validations

  # multilanguage validations
  validates :title, presence: true

  validate :validates_globalized_attributes

  acts_as_paranoid

  before_save :set_sort_order,  if: :new_record?
  before_save :set_slug,        if: :new_record?
  before_save :set_meta_title

  # associations
  has_one_attached :image do |attachable|
    attachable.variant :admin, resize_to_fit: [300, 300], preprocessed: true
    attachable.variant :for_home , resize_to_fit: [532, 716], preprocessed: true
  end

  has_one_attached :second_image do |attachable|
    attachable.variant :admin, resize_to_fit: [300, 300], preprocessed: true
    attachable.variant :for_home , resize_to_fit: [298, 387], preprocessed: true
  end

  has_one_attached :sub_image do |attachable|
    attachable.variant :admin, resize_to_fit: [300, 300], preprocessed: true
    attachable.variant :sub, resize_to_fill: [400, 400], preprocessed: true
  end

  scope :common,       -> { order(sort_order: :asc) }
  scope :menu,         -> { common.where(menu: true)}
  scope :footer,       -> { common.where(footer: true)}
  scope :quick_links,  -> { common.where(qlink: true) }
  scope :published,    -> { common.where(status: true) }

  private

  def self.about
    self.find_by(handle: "about")
  end

  def set_slug
    I18n.available_locales.each do |locale|

      next if self.send("title_#{locale}").blank?

      slug = self.convert_cas(self.send("title_#{locale}"))

      # we check if slug already exists and if yes we add -1, -2, -3, etc.
      while Page.joins(:translations).where("page_translations.slug = ? AND page_translations.locale = ?", slug, locale.to_s).exists?
        slug = slug + "-#{Page.joins(:translations).where("page_translations.slug = ? AND page_translations.locale = ?", slug, locale.to_s).count}"
      end

      self.send("slug_#{locale}=", slug).gsub("_#{locale}", '')
    end
  end

  def set_meta_title
    I18n.available_locales.each do |locale|
      self.send("meta_title_#{locale}=", self.send("title_#{locale}"))
    end
  end

  def set_sort_order
    self.sort_order = Page.maximum(:sort_order).to_i + 1
  end
end
