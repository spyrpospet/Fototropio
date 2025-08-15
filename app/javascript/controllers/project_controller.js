import { Controller } from "@hotwired/stimulus"
import { Fancybox } from "vendor/fancybox.esm"
import "vendor/glide"

// Connects to data-controller="project"
export default class extends Controller {
  static targets = [ "slider" ]

  connect() {
    this.init_slider()
    this.init_fancybox()
  }

  init_slider() {

    new Glide(this.sliderTarget, {
      type: 'carousel',
      startAt: 0,
      perView: 1,
      focusAt: 'center',
      gap: 0,
      peek: {
        before: 300,
        after: 300
      },
      breakpoints: {
        1440: {
          peek: {
            before: 100,
            after: 100
          },
        },
        1024: {
          peek: {
            before: 100,
            after: 100
          },
        }
      },
      arrows: true,
      animationDuration: 600, // Transition duration in ms
      animationTimingFunc: 'cubic-bezier(0.165, 0.840, 0.440, 1.000)', // Easing

    }).mount()
  }

  init_fancybox() {
    const fancybox_items = document.querySelectorAll("[data-fancybox]");

    if(!fancybox_items) return

    Fancybox.bind("[data-fancybox]");
  }
}
