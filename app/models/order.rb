class Order < ApplicationRecord
  include ActiveModel::Translation

  # callbacks
  before_save   :set_sort_order
  before_save   :set_totals, :set_total
  before_create :set_code

  # constants
  STATUS            = { pending: 0, incomplete: 1, complete: 2, canceled: 3}
  PAYMENT_MESSAGES  = {
    "pay_on_delivery" => I18n.t("pay_on_delivery"),
    "bank_transfer" => I18n.t("bank_transfer"),
    "credit_debit_card" => I18n.t("credit_debit_card"),
  }
  SEND_MESSAGES = {
    "delivery_to_your_location" => I18n.t("delivery_to_your_location"),
    "pickup_from_store" => I18n.t("pickup_from_store"),
  }
  DOCUMENT_MESSAGES = {
    "invoice" => I18n.t("invoice"),
    "receipt" => I18n.t("receipt"),
  }


  # scopes
  scope :common,            -> { order(sort_order: :asc) }
  scope :pending_state,     -> { where(status: STATUS[:pending]) }
  scope :incomplete_state,  -> { where(status: STATUS[:incomplete]) }
  scope :complete_state,    -> { where(status: STATUS[:complete]) }
  scope :canceled_state,    -> { where(status: STATUS[:canceled]) }

  # validations
  validates :status, presence: true
  validates :sort_order, presence: true

  def gross_total
    data["products"].sum { |item| item["total"].to_d }
  end

  def total_quantity
    data["products"].sum { |item| item["quantity"].to_i }
  end

  def net_total
    total = gross_total

    total
  end

  def has_products?
    data["products"].present?
  end

  private

  def set_sort_order
    self.sort_order = Order.maximum(:sort_order).to_i + 1
  end

  def set_totals
    data["products"].each do |item|
      item["total"] = item["price"].to_d * item["quantity"].to_i
    end
  end

  def set_total
    self.total = net_total
  end

  def set_code
    code = SecureRandom.hex(10)

    # check if code is unique in loop
    while Order.exists?(code: code)
      code = SecureRandom.hex(10)
    end

    self.code = code
  end
end
