class Banner < ApplicationRecord
  include Banner::Search

  translates :title, :sub_title
  globalize_accessors locales: I18n.available_locales, attributes: %i[title sub_title]

  before_save :set_sort_order, if: :new_record?

  # constants
  HOME              = 'home'
  HOME_BEST_SELLER  = 'home_best_sellers'
  STATUSES          = { published: true, unpublished: false }.freeze


  has_one_attached :image do |attachable|
    attachable.variant :admin, resize_to_fill: [300, 300], preprocessed: true
    attachable.variant :thumbnail, resize_to_fill: [100, 100], preprocessed: true
    attachable.variant :home, resize_to_fill: [650, 660], preprocessed: true
    attachable.variant :home_best_seller, resize_to_fill: [650, 450], preprocessed: true
  end

  # scopes
  scope :common,            -> { order(sort_order: :asc) }
  scope :home,              -> { common.where(position: HOME) }
  scope :published,         -> { where(status: true) }

  def self.home_best_seller
    find_by(position: HOME_BEST_SELLER)
  end

  private

  def set_sort_order
    self.sort_order = Banner.maximum(:sort_order).to_i + 1
  end
end
