import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="item"
export default class extends Controller {
  static targets = [
      "wrapper",
      "destroyField"
  ]

  connect() {}

  remove(event) {
    this.element.closest(".item").remove()
  }
}
