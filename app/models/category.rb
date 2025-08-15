class Category < ApplicationRecord
  include Category::Search
  include CustomTools
  extend Pagy::Meilisearch
  ActiveRecord_Relation.include Pagy::Meilisearch

  has_rich_text :description
  has_ancestry
  acts_as_paranoid

  translates :title, :description, :meta_title, :meta_description, :slug
  globalize_accessors locales: I18n.available_locales, attributes: %i[title description meta_title meta_description slug]
  globalize_validations

  # multilanguage validations
  validates :title, presence: true

  validate :validates_globalized_attributes

  before_save :update_product_prices
  before_save :set_sort_order,  if: :new_record?
  before_save :set_slug,        if: :new_record?
  before_save :set_handle,      if: :new_record?
  before_save :set_meta_title

  # constants
  STATUS = { published: true, unpublished: false }.freeze

  # associations
  has_one_attached :image do |attachable|
    attachable.variant :admin, resize_to_limit: [862, 324], preprocessed: true
    attachable.variant :category, resize_to_fit: [1920, 430], preprocessed: true
    attachable.variant :category_md, resize_to_fit: [768, 325], preprocessed: true
    attachable.variant :category_sm, resize_to_fit: [576, 169], preprocessed: true
    attachable.variant :category_xs, resize_to_fit: [425, 125], preprocessed: true
    attachable.variant :sub_category, resize_and_pad: [450, 450, gravity: :centre, background: [255, 255, 255]], preprocessed: true
    attachable.variant :home, resize_to_fill: [350, 40], preprocessed: true
  end

  has_one_attached :size_guide

  has_many :pages
  has_many :published_pages, -> { published }, class_name: 'Page'

  has_many :categories_posts, dependent: :destroy
  has_many :posts, through: :categories_products
  has_many :published_posts, -> { published }, through: :categories_posts, source: :post

  has_many :categories_products, dependent: :destroy
  has_many :products, through: :categories_products
  has_many :published_products, -> { published }, through: :categories_products, source: :product

  has_and_belongs_to_many :brands

  # scope
  scope :common,          -> { with_attached_image.order(sort_order: :asc) }
  scope :top_menu,        -> { common.where(menu: true, ancestry: "/") }
  scope :menu,            -> { common.where(menu: true) }
  scope :published,       -> { common.where(status: STATUS[:published]) }
  scope :alphabetically,  -> { common.joins(:translations).order("LOWER(title) DESC") }


  private

  def set_slug
    I18n.available_locales.each do |locale|

      next if self.send("title_#{locale}").blank?

      slug = self.convert_cas(self.send("title_#{locale}"))

      # we check if slug already exists and if yes we add -1, -2, -3, etc.
      while Category.joins(:translations).where("category_translations.slug = ? AND category_translations.locale = ?", slug, locale.to_s).exists?
        slug = slug + "-#{Category.joins(:translations).where("category_translations.slug = ? AND category_translations.locale = ?", slug, locale.to_s).count}"
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

  def update_product_prices
    # Early returns for edge cases
    return if product_price_percentage.nil? || product_price_percentage.to_f.zero?
    return if product_price_percentage.to_f <= -100
    return unless (price_change_from_product_code_changed? || price_change_to_product_code_changed? || product_price_percentage_changed?)
    # return if price_change_from_product_code.to_i.zero? || price_change_to_product_code.to_i.zero?

    # Get all categories including this one and all its descendants
    all_categories = [self] + descendants

    # Get all products using a simpler query to avoid JSON comparison issues
    category_ids  = all_categories.map(&:id)
    product_ids   = CategoriesProduct.where(category_id: category_ids).pluck(:product_id).uniq
    all_products  = Product.where(id: product_ids)

    # Filter products by code range if both fields are populated
    all_products = all_products.where("CAST(REGEXP_REPLACE(code, '[^0-9]', '', 'g') AS integer) >= ? AND CAST(REGEXP_REPLACE(code, '[^0-9]', '', 'g') AS integer) <= ?",
                                      price_change_from_product_code,
                                      price_change_to_product_code)

    # Calculate the adjustment factor
    adjustment_factor = 1 + (product_price_percentage.to_f / 100)

    # Update each product's price
    all_products.each do |product|
      new_price = product.price * adjustment_factor
      new_price = [new_price, 0.01].max
      product.update_column(:price, new_price.round(2))
    end
  end



  def set_sort_order
    self.sort_order = Category.maximum(:sort_order).to_i + 1
  end

end