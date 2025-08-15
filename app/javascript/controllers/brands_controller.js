import { Controller } from "@hotwired/stimulus"
import "vendor/glide"

// Connects to data-controller="brands"
export default class extends Controller {
  static targets = ["brandsList"]

  connect() {
    this.init_slider()
  }

  init_slider() {
    if (!this.hasBrandsListTarget) return

    new Glide(this.brandsListTarget, {
      type: 'carousel',
      perView: 6,
      gap: 20,
      autoplay: 2000,
      breakpoints: {
        1024: {
          perView: 6
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
