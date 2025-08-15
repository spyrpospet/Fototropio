class OptionsProductsItem < ApplicationRecord
  belongs_to :options_product, touch: true
  belongs_to :item

  has_one_attached :image, dependent: :destroy

  def net_price
    if price.to_d.positive? && offer.to_i.positive?
      (offer < price) ? offer : price
    elsif price.to_d.zero? && offer.to_d.positive?
      offer
    else
      price
    end
  end
end
