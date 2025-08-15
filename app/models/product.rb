class Product < ApplicationRecord
  # include Product::Search
  include CustomTools
  # extend Pagy::Meilisearch
  # ActiveRecord_Relation.include Pagy::Meilisearch

  translates :title, :description, :short_description, :meta_title, :meta_description, :slug
  globalize_accessors locales: I18n.available_locales, attributes: %i[title description short_description meta_title meta_description slug]
  globalize_validations

  # multilanguage validations
  validates :title, presence: true

  validate :validates_globalized_attributes

  # validations
  validates :code, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :availability_id, presence: true, numericality: { greater_than: 0 }
  validates :categories, presence: true

  acts_as_paranoid

  before_save :set_sort_order,  if: :new_record?
  before_save :set_slug,        if: :new_record?
  before_save :set_meta_title
  before_save :set_price

  # constants
  STATUSES = { published: true, unpublished: false }.freeze

  # associations
  has_many_attached :images, dependent: :destroy do |attachable|
    attachable.variant :admin, resize_and_pad: [200, 200, gravity: :centre, background: [255, 255, 255]], preprocessed: true

    attachable.variant :category, resize_and_pad: [450, 450, gravity: :centre, background: [255, 255, 255]], preprocessed: true
    attachable.variant :category_425, resize_and_pad: [400, 400, gravity: :centre, background: [255, 255, 255]], preprocessed: true
    attachable.variant :category_768, resize_and_pad: [350, 350, gravity: :centre, background: [255, 255, 255]], preprocessed: true
    attachable.variant :category_1024, resize_and_pad: [300, 300, gravity: :centre, background: [255, 255, 255]], preprocessed: true
    attachable.variant :category_1440, resize_and_pad: [350, 350, gravity: :centre, background: [255, 255, 255]], preprocessed: true

    attachable.variant :new_arrivals, resize_and_pad: [350, 350,  background: [255, 255, 255]], preprocessed: true
    attachable.variant :home_best_seller, resize_and_pad: [300, 340, gravity: :centre, background: [255, 255, 255]], preprocessed: true
    attachable.variant :product, resize_to_limit: [640, 750], preprocessed: true
    attachable.variant :product_thumbnail, resize_to_fit: [160, 160], preprocessed: true
  end

  has_many :categories_products, dependent: :destroy
  has_many :categories, through: :categories_products
  has_many :published_categories, -> { published }, through: :categories_products, source: :category

  has_many :options_products, dependent: :destroy
  has_many :published_options_products, -> { not_characteristics.joins(:option).merge(Option.published) }, class_name: "OptionsProduct"

  has_many :options, through: :options_products, source: :option
  has_many :published_options, -> { merge(OptionsProduct.options) }, through: :options_products, source: :option

  has_many :filters, -> { merge(OptionsProduct.filters) }, through: :options_products, source: :option
  has_many :published_filters, -> { merge(OptionsProduct.filters).merge(Option.published) }, through: :options_products, source: :option
  has_many :characteristics, -> { merge(OptionsProduct.characteristics) }, through: :options_products, source: :option
  has_many :published_characteristics, -> { merge(OptionsProduct.characteristics).merge(Option.published) }, through: :options_products, source: :option

  # has_many :related_products, dependent: :destroy
  # has_many :related, through: :related_products, source: :related_product

  has_many :tabs, dependent: :destroy

  belongs_to :category, optional: true
  belongs_to :availability
  belongs_to :brand, optional: true
  belongs_to :label, optional: true

  # validations
  validates :title, presence: true

  accepts_nested_attributes_for :tabs, allow_destroy: true
  accepts_nested_attributes_for :categories_products, allow_destroy: true
  accepts_nested_attributes_for :options_products, allow_destroy: true

  # scopes
  scope :common,        -> { order(sort_order: :asc) }
  scope :new_arrivals,  -> { where(new_arrival: true).order(sort_order: :desc) }
  scope :best_sellers,  -> { common.where(best_seller: true) }
  scope :published,     -> { common.where(status: true) }

  # public methods

  def main_image
    @mail_image ||= images.order(:position).first
  end

  def net_price
    net_price = (offer.present? && !offer.zero? ? offer : price)

    net_price
  end

  def first_category
    categories.first
  end

  def on_sale?
    offer.present? && !offer.zero? && offer < price
  end

  def sale_percentage
    return 0 if price.zero?

    ((price - offer) / price * 100).round
  end

  def has_jewel_specifications?
    material_metal.present? ||
      gold_karats.present? ||
      finish.present? ||
      weight.present? ||
      stone.present? ||
      stone_cutting.present? ||
      stone_weight.present? ||
      stone_color.present? ||
      stone_purity.present? ||
      jewelry_dimensions.present?
  end

  def net_price_with_selected_items(items)
    items = items.map { |i| i.to_i }

    p = 0

    # sum items net prices and product net price
    p += options_products.flat_map do |op|
      op.options_products_item.filter_map do |i|
        i.net_price if items.include?(i.id)
      end
    end.sum

    p
  end

  private

  def has_price_change_from_categories?
    categories.present? && categories.any? { |c| c.product_price_percentage.to_i.positive? }
  end

  def set_slug
    I18n.available_locales.each do |locale|

      next if self.send("title_#{locale}").blank?

      slug = convert_cas(self.send("title_#{locale}"))

      # we check if slug already exists and if yes we add -1, -2, -3, etc.
      while Product.joins(:translations).where("product_translations.slug = ? AND product_translations.locale = ?", slug, locale.to_s).exists?
        slug = slug + "-#{Product.joins(:translations).where("product_translations.slug = ? AND product_translations.locale = ?", slug, locale.to_s).count}"
      end

      self.send("slug_#{locale}=", slug).gsub("_#{locale}", '')
    end
  end

  def set_meta_title
    I18n.available_locales.each do |locale|
      self.send("meta_title_#{locale}=", self.send("title_#{locale}")) if self.send("meta_title_#{locale}").blank?
    end
  end


  def set_price
    self.price = 0 if price.nil?
  end

  def set_sort_order
    self.sort_order = Product.maximum(:sort_order).to_i + 1
  end
end
