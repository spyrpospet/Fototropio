class Slider < ApplicationRecord
  include Slider::Search

  before_save :set_sort_order, if: :new_record?

  # constants
  STATUSES = { published: true, unpublished: false }.freeze

  # association
  has_one_attached :image do |attachable|
    attachable.variant :thumbnail, resize_to_fill: [100, 100], preprocessed: true
    attachable.variant :large, resize_to_fill: [1920, 1024], preprocessed: true
    attachable.variant :slider, resize_to_fill: [1920, 880], preprocessed: true
  end

  # scope
  scope :common,    -> { order(sort_order: :asc) }
  scope :published, -> { common.where(status: STATUSES[:published]) }

  private

  def set_sort_order
    self.sort_order = Slider.maximum(:sort_order).to_i + 1
  end
end
