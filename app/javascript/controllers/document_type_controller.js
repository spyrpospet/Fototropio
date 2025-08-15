import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="document-type"
export default class extends Controller {
  static targets = [ "field" ]

  connect() {
  }

  change_type(event) {
   let invoice_fields   = document.querySelectorAll('.invoice-field')
   const value          = event.currentTarget.querySelector('input').value

    if (invoice_fields && value === 'invoice') {
        invoice_fields.forEach((field) => {
            field.classList.remove('hidden');
        })
    } else {
        invoice_fields.forEach((field) => {
            field.classList.add('hidden');
        })
    }
  }
}
