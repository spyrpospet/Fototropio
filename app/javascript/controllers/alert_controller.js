import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="alert"
export default class extends Controller {
  static outlets = [ "common" ]

  connect() {
    this.remove_after_3_seconds()
    this.scroll_to_alert()
  }

  remove_after_3_seconds() {
    setTimeout(() => {
      this.element.remove()
    }, 3000)
  }

  remove(event) {
    this.element.remove()
  }

  scroll_to_alert(event) {
    this.commonOutlet.scroll_to_element(this.element)
  }
}
