import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="header"
export default class extends Controller {
  static outlets = ["mobile-menu", "search", "vivid-card"]

  connect() {
  }

  open_menu() {
    this.mobileMenuOutlet.open_menu()
  }

  open_search() {
    this.searchOutlet.open()
  }

  toggle_vivid_card(event) {
    if (event) event.preventDefault()

    if (this.hasVividCardOutlet) {
      this.vividCardOutlet.toggle(event)
    }
  }

  close_vivid_card() {
    if (this.hasVividCardOutlet) {
      this.vividCardOutlet.close()
    }
  }
}
