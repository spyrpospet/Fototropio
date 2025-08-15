import { Controller } from "@hotwired/stimulus"
import { post } from "@rails/request.js"

// Connects to data-controller="checkout"
export default class extends Controller {
  connect() {
  }

  change_quantity(event) {
    const quantity   = event.currentTarget.closest('.quantity').querySelector('input').value
    const product_id = event.currentTarget.dataset.productId

    post(`/checkout/change-quantity`, {
            body: {
                quantity: quantity,
                product_id: product_id,
            },
            responseKind: 'turbo-stream'
    })
  }

  delete_item(event) {
    const delete_id = event.currentTarget.dataset.deleteId

    post(`/checkout/remove-from-cart`, {
            body: {
                delete_id: delete_id,
            },
            responseKind: 'turbo-stream'
    })
  }
}
