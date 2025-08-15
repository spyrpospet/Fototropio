import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="csv"
export default class extends Controller {
  static targets = ["form","fileInput", "loader"]

  connect() {
    document.addEventListener('turbo:render', () => {
      this.hide_loader()
    })
  }

  add_file() {
    this.fileInputTarget.click()
  }

  send_file() {
    this.show_loader()
    this.formTarget.requestSubmit()
  }

  show_loader() {
    this.loaderTarget.classList.remove("hidden")
  }

  hide_loader() {
    this.loaderTarget.classList.add("hidden")
  }
}
