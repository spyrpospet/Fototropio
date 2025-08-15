class Country < ApplicationRecord
  has_many :regions, dependent: :destroy
  has_many :published_regions, -> { published }, class_name: 'Region'

  scope :common,    -> { order(sort_order: :asc) }
  scope :published, -> { common.where(status: true) }
end
