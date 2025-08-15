import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quantity"
export default class extends Controller {
  static targets = ["input"]

  connect() {
  }

  increment() {
    this.inputTarget.value = parseInt(this.inputTarget.value) + 1
  }

  decrement() {
      if (this.inputTarget.value > 1) {
        this.inputTarget.value = parseInt(this.inputTarget.value) - 1
      }
  }

}
