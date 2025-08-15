import { Controller } from "@hotwired/stimulus"
import "vendor/glide"

// Connects to data-controller="new-arrivals"
export default class extends Controller {
  static targets = ["newArrivals"]

  connect() {
    this.init_slider()
  }

  init_slider() {
    new Glide(this.newArrivalsTarget, {
      type: 'carousel',
      perView: 4,
      breakpoints: {
        1024: {
          perView: 4
        },
        768: {
          perView: 3
        },
        425: {
          perView: 1
        }
      }
    }).mount()
  }
}
