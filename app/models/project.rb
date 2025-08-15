class Project < ApplicationRecord
  include CustomTools
  
  translates :title, :description, :slug
  globalize_accessors locales: I18n.available_locales, attributes: %i[title description slug]
  globalize_validations

  # multilanguage validations
  validates :title, presence: true

  validate :validates_globalized_attributes

  before_save :set_sort_order,  if: :new_record?
  before_save :set_slug,        if: :new_record?
  
  # associations
  has_one_attached :image do |attachable|
    attachable.variant :admin, resize_to_fit: [300, 300], preprocessed: true
    attachable.variant :home , resize_to_fit: [1300, 950], preprocessed: true
  end

  scope :common,    -> { order(sort_order: :asc) }
  scope :published, -> { common.where(status: true) }

  private

  def set_slug
    I18n.available_locales.each do |locale|

      next if self.send("title_#{locale}").blank?

      slug = self.convert_cas(self.send("title_#{locale}"))

      # we check if slug already exists and if yes we add -1, -2, -3, etc.
      while Project.joins(:translations).where("project_translations.slug = ? AND project_translations.locale = ?", slug, locale.to_s).exists?
        slug = slug + "-#{Project.joins(:translations).where("project_translations.slug = ? AND project_translations.locale = ?", slug, locale.to_s).count}"
      end

      self.send("slug_#{locale}=", slug).gsub("_#{locale}", '')
    end
  end

  def set_sort_order
    self.sort_order = Project.maximum(:sort_order).to_i + 1
  end
end
