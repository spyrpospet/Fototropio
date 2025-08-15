import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu"
export default class extends Controller {
  connect() {
  }

  show_sub() {
    const sub = this.element.querySelector('.sub')
    sub.classList.remove('animate__fadeOutDown')
    sub.classList.add('animate__fadeInUp')
    sub.classList.remove('hidden')
  }

  hide_sub() {
    const sub = this.element.querySelector('.sub')
    sub.classList.add('animate__fadeOutDown')
    sub.classList.remove('animate__fadeInUp')
  }
}
