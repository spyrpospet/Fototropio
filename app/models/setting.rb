class Setting < ApplicationRecord
  store :data, accessors: [
    :website,
    :email,
    :phone,
    :address,
    :bank_url,
    :merchant_id,
    :bank_secret_key,
    :facebook,
    :instagram,
    :youtube,
    :bank_deposit_instruction
  ], coder: JSON

  has_one_attached :logo do |attachable|
    attachable.variant :logo, resize_to_fill: [250, 100]
    attachable.variant :mobile_logo, resize_and_pad: [150, 50, gravity: :centre]
  end
end
