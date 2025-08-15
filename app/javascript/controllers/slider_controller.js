import { Controller } from "@hotwired/stimulus"
import "vendor/glide"

// Connects to data-controller="slider"
export default class extends Controller {
  static targets = [ "slider", "navItem" ]

  connect() {
    this.init_slider()
  }

  init_slider() {
    const glide = new Glide(this.sliderTarget)

    // Add event listener for slide change
    glide.on('run.before', (event) => {
      // Get the current slide index
      const index = event ? event.steps : 0

      // Remove active class from all nav items
      this.navItemTargets.forEach((item, i) => {

        if (i == index) {
          item.classList.add('text-[#C3B8A5]')
        } else {
          item.classList.remove('text-[#C3B8A5]')
        }
      })
    })

    glide.mount()
  }
}
