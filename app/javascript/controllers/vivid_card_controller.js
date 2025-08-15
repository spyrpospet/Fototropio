import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="vivid-card"
export default class extends Controller {
  static targets = ["card"]

  connect() {
    // Close card when clicking outside
    document.addEventListener('click', this.handleOutsideClick.bind(this))
  }

  disconnect() {
    document.removeEventListener('click', this.handleOutsideClick.bind(this))
  }

  toggle(event) {
    if (event) event.preventDefault()

    if (this.hasCardTarget) {
      // For right side panel, translate-x-full means "off screen to the right"
      // and translate-x-0 means "visible in normal position"
      if (this.cardTarget.classList.contains('translate-x-full')) {
        this.cardTarget.classList.remove('translate-x-full')
        this.cardTarget.classList.add('translate-x-0')
      } else {
        this.cardTarget.classList.remove('translate-x-0')
        this.cardTarget.classList.add('translate-x-full')
      }
    }
  }

  close() {
    if (this.hasCardTarget && this.cardTarget.classList.contains('translate-x-0')) {
      this.cardTarget.classList.remove('translate-x-0')
      this.cardTarget.classList.add('translate-x-full')
    }
  }

  handleOutsideClick(event) {
    // Close vivid card when clicking outside
    if (this.hasCardTarget && this.cardTarget.classList.contains('translate-x-0')) {
      if (!this.cardTarget.contains(event.target) && !event.target.closest('#vivid-button')) {
        this.toggle()
      }
    }
  }
}
