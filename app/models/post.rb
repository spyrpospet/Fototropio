class Post < ApplicationRecord
  include Post::Search
  include CustomTools
  extend Pagy::Meilisearch
  ActiveRecord_Relation.include Pagy::Meilisearch
  
  translates :title, :description, :meta_title, :meta_description, :slug
  globalize_accessors locales: I18n.available_locales, attributes: %i[title description meta_title meta_description slug]
  globalize_validations

  # multilanguage validations
  validates :title, presence: true

  validate :validates_globalized_attributes

  before_save :set_sort_order,  if: :new_record?
  before_save :set_slug,        if: :new_record?
  before_save :set_meta_title

  has_one_attached :image do |attachable|
    attachable.variant :admin, resize_to_fit: [300, 300], preprocessed: true
    attachable.variant :home , resize_to_fit: [719, 349], preprocessed: true
  end

  has_many :categories_posts, dependent: :destroy
  has_many :categories, through: :categories_posts, source: :category

  scope :common,              -> { order(sort_order: :asc) }
  scope :reversed,            -> { order(sort_order: :desc) }
  scope :popular,             -> { common.where(popular: true) }
  scope :published,           -> { common.where(status: true) }
  scope :reversed_published,  -> { reversed.where(status: true) }

  def main_category
    @main_category ||= categories&.first
  end
  
  private

  def set_slug
    I18n.available_locales.each do |locale|

      next if self.send("title_#{locale}").blank?

      slug = self.convert_cas(self.send("title_#{locale}"))

      # we check if slug already exists and if yes we add -1, -2, -3, etc.
      while Post.joins(:translations).where("post_translations.slug = ? AND post_translations.locale = ?", slug, locale.to_s).exists?
        slug = slug + "-#{Post.joins(:translations).where("post_translations.slug = ? AND post_translations.locale = ?", slug, locale.to_s).count}"
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
    self.sort_order = Post.maximum(:sort_order).to_i + 1
  end
end
