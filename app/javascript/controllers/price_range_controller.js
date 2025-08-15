import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="price-range"
export default class extends Controller {
  static targets = ["minShow","maxShow", "range"]

  connect() {
  }

  range_changed(event) {
    this.minShowTarget.textContent = this.rangeTarget.value
  }
}
