class Region < ApplicationRecord
  belongs_to :country

  scope :common,    -> { order(sort_order: :asc) }
  scope :published, -> { common.where(status: true) }
end
