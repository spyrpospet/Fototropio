import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mobile"
export default class extends Controller {
  static outlets = ["header"]

  connect() {}

  open_search() {
    this.headerOutlet.open_search()
  }
}
