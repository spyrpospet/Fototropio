import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cardlink"
export default class extends Controller {
  connect() {
    // Listen for turbo:stream-end event and submit the form
    this.submitForm()
  }

  submitForm() {
    // Get the form and submit it
    const form = this.element.querySelector('#cardlink_post')

    if (form) form.submit()
  }
}
