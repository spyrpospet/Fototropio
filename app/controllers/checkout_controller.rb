class CheckoutController < CommonController
  skip_before_action :verify_authenticity_token, only: [:order_success, :order_fail]

  def index
    order_id = session["cart"]["order_id"]
    @order   = Order.pending_state.find_by(id: order_id) if order_id.present?
  end

  def add_to_cart
    @product         = Product.published.find_by(id: product_params[:product_id])
    order_exclude    = %w[code quantity price url total delete_id]

    I18n.available_locales.each { |locale| order_exclude << "title_#{locale}" }

    params_exclude   = %w[quantity]
    is_new           = true

    if @product.present?
      order_id                = session["cart"]["order_id"]

      @order                  = Order.find_or_initialize_by(id: order_id)

      item = {
        "product_id"        => @product.id,
        "code"              => @product.code,
        "price"             => @product.net_price,
        "url"               => map_url(@product.first_category.slug, @product.slug),
        "quantity"          => (product_params[:quantity].to_i > 0 ? product_params[:quantity].to_i : 1),
        "option_items_ids"  => product_params[:option_items_ids],
        "items"             => [],
        "total"             => 0,
        "delete_id"         => SecureRandom.uuid
      }

      I18n.available_locales.each do |locale|
        item["title_#{locale}"] = @product.title(locale)
      end

      product_params[:option_items_ids]&.each do |id|
        object_item = OptionsProductsItem.find(id)
        item["items"] << { "title" => object_item.item.title, "total" => @product.net_price_with_selected_items(product_params[:option_items_ids]) }
      end

      if @order.new_record?

        @order.data             ||= {}
        @order.data["products"] ||= []
        @order.data["products"] << item
        @order.save

        session["cart"]["order_id"] = @order.id
      else
        @order.data["products"]&.each do |item|
          except_item   = item.except(*order_exclude).transform_values{ |v| !v.is_a?(Array) ? v.to_s : v }
          except_params = product_params.to_h.except(*params_exclude)

          next if except_item != except_params

          item["quantity"] += item["quantity"].to_i

          is_new = false
          break
        end

        @order.data["products"] << item if is_new
        @order.save
      end
    end
  end

  def remove_from_cart
    @order = Order.find(session["cart"]["order_id"])

    @order.data["products"].delete_if do |item|
      item["delete_id"] === params[:delete_id]
    end

    @order.save
  end

  def change_quantity
    @order = Order.find(session["cart"]["order_id"])

    @order.data["products"].each do |item|
      next if item["product_id"].to_i != params[:product_id].to_i

      item["quantity"] = params[:quantity].to_i

      break
    end

    @order.save
  end

  def submit
    @order   = Order.pending_state.find_by(id: session["cart"]["order_id"])

    return unless validate_personal_information
    return unless validate_terms_agreement

    @order.data   = @order.data.merge(checkout_params.to_h)

    if @order.save
      if @order.data["payment_method"] == "credit_debit_card"
        cardlink
      else

        @order.status = Order::STATUS[:complete]
        @order.save

        session["cart"]["order_id"] = nil

        OrderMailer.with(order: @order).notify_client.deliver_later
        OrderMailer.with(order: @order).notify_admin.deliver_later

        respond_to do |format|
          format.turbo_stream { render turbo_stream: turbo_stream.update("checkout-form", partial: "/checkout/p_order_success") }
        end
      end
    else
      session["cart"]["order_id"] = nil

      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.update("checkout-form", partial: "/checkout/p_order_fail") }
      end
    end
  end
  
  def cardlink
    @order                = Order.find(session["cart"]["order_id"])

    @merchant_id          = "0020886776"
    @secret               = "qq7fia3aD4JrEs9aiJXrrw"

    @form_data_array      = []
    @form_data_array[1]   = "2"
    @form_data_array[2]   = @merchant_id
    @form_data_array[3]   = ''
    @form_data_array[4]   = ''
    @form_data_array[5]   = @order.id
    @form_data_array[6]   = ''
    @form_data_array[7]   = @order.total
    @form_data_array[8]   = 'EUR'
    @form_data_array[9]   = @order.data['email']
    @form_data_array[10]  = ''
    @form_data_array[11]  = 'GR'
    @form_data_array[12]  = 'Greece'
    @form_data_array[13]  = @order.data['postal_code']
    @form_data_array[14]  = @order.data['region']
    @form_data_array[15]  = @order.data['address']
    @form_data_array[16]  = ''
    @form_data_array[17]  = ''
    @form_data_array[18]  = ''
    @form_data_array[19]  = ''
    @form_data_array[20]  = ''
    @form_data_array[21]  = ''
    @form_data_array[22]  = ''
    @form_data_array[23]  = ''
    @form_data_array[24]  = ''
    @form_data_array[25]  = ''
    @form_data_array[26]  = ''
    @form_data_array[27]  = '2'
    @form_data_array[28]  = (@order.data['installments'] && @order.data['installments'] != "0" ? 0 : "")
    @form_data_array[29]  = (@order.data['installments'] && @order.data['installments'] != "0" ? @order.data['installments'] : "")
    @form_data_array[30]  = ''
    @form_data_array[31]  = ''
    @form_data_array[32]  = ''
    @form_data_array[33]  = ''
    @form_data_array[34]  = checkout_order_success_url
    @form_data_array[35]  = checkout_order_fail_url
    @form_data_array[36]  = ''
    @form_data_array[37]  = ''
    @form_data_array[38]  = ''
    @form_data_array[39]  = ''
    @form_data_array[41]  = ''
    @form_data_array[42]  = ''
    @form_data_array[43]  = ''
    @form_data_array[44]  = ''
    @form_data_array[45]  = ''
    @form_data_array[46]  = ''
    @form_data_array[47]  = ''
    @form_data_array[48]  = @secret

    @form_data            = @form_data_array.join("")
    @digest               = Base64.encode64(Digest::SHA256.digest(@form_data)).gsub(/\n/, "")

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.update("checkout-form", partial: "/checkout/cardlink") }
    end
  end

  def order_success
    order_id = params[:orderid] || session["cart"]["order_id"]
    @order   = Order.pending_state.find_by(id: order_id)

    return if @order.nil?

    @order.status = Order::STATUS[:complete]
    @order.save

    session["cart"]["order_id"] = nil

    OrderMailer.with(order: @order).notify_client.deliver_later
    OrderMailer.with(order: @order).notify_admin.deliver_later
  end

  def order_fail
    session["cart"]["order_id"] = nil
  end

  private

  def validate_terms_agreement
    @params  = checkout_params
    is_valid = @params["terms_agreement"].present?

    unless is_valid
      respond_to do |format|
        format.turbo_stream { render partial: "checkout/validations/terms_agreement" }
      end

      false
    else
      true
    end
  end
  def validate_personal_information
    @params  = checkout_params
    is_valid = true
    required_fields   = %w[first_name last_name email mobile address postal_code country region]
    phone_fields      = %w[phone mobile]
    condition_fields  = %w[company_name social_security_number doy profession]

    # if phone fields are not 10 digits return false
    phone_fields.each do |field|
      if @params[field].present? && @params[field].length != 10
        is_valid = false
        break
      end
    end

    required_fields.each do |field|
      if @params[field].blank?

        is_valid = false
        break
      end
    end

    if is_valid
      condition_fields.each do |field|
        if @params[field].blank? && @params["document_type"] == "invoice"

          is_valid = false
          break
        end
      end
    end

    unless is_valid
      respond_to do |format|
        format.turbo_stream { render partial: "checkout/validations/personal_information" }
      end

      false
    else
      true
    end
  end

  def product_price(product)
    product["price"].to_d * product["quantity"].to_i
  end

  def product_params
    params.fetch(:product, {}).permit(:product_id, :quantity, option_items_ids: [])
  end

  def checkout_params
    params.fetch(:checkout, {}).permit(
      :company_name,
      :social_security_number,
      :doy,
      :profession,
      :first_name,
      :last_name,
      :email,
      :phone,
      :mobile,
      :address,
      :city,
      :postal_code,
      :region,
      :country,
      :document_type,
      :send_method,
      :payment_method,
      :comments,
      :installments,
      :terms_agreement
    )
  end
end
