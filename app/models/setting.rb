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
    attachable.variant :logo, resize_to_fit: [300, 150]
    attachable.variant :mobile_logo, resize_to_fit: [150, 50]
  end
end
