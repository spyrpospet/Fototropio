import { Controller } from "@hotwired/stimulus"
import { post } from "@rails/request.js"

// Connects to data-controller="mass-selection"
export default class extends Controller {
  static targets = [ "items" ]

  connect() {
  }

  toggle_all(event) {
    this.itemsTargets.forEach(item => item.checked = event.target.checked)
  }

  mass_destroy(event) {
    event.preventDefault()

    const product_ids = this.itemsTargets.filter(item => item.checked).map(item => item.value)

     post(`/administration/products/mass-destroy`, {
        body: {
            ids: product_ids
        },
        responseKind: 'turbo-stream'
    })
  }
}
