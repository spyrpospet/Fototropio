import { Controller } from "@hotwired/stimulus"
import "vendor/glide"

// Connects to data-controller="see-more"
export default class extends Controller {
  static targets = ["seeMore"]

  connect() {
    this.init_slider()
  }

    init_slider() {
      new Glide(this.seeMoreTarget, {
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
