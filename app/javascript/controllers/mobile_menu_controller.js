import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mobile-menu"
export default class extends Controller {
  static targets = ["wrapper", "secondLevel", "thirdLevel"]

  connect() {
  }

  open_menu() {
    let animation = this.wrapperTarget.animate({"left": "0"}, 300, "ease-in")

    animation.onfinish = () => {
       this.wrapperTarget.style.left = "0"
    }
  }

  close_menu() {
    let animation = this.wrapperTarget.animate({"left": "-1000"}, 300, "ease-out")

    animation.onfinish = () => {
      this.wrapperTarget.style.left = "-1000"
    }
  }

    toggle_second_level(event) {
      const slug = event.currentTarget.dataset.slug

     if(this.hasSecondLevelTarget) {
        this.secondLevelTargets.forEach((element) => {
          if(element.dataset.slug === slug) {
              if(element.classList.contains("hidden")) {
                  element.classList.remove("hidden")
              } else {
                  element.classList.add("hidden")
              }
          } else {
            element.classList.add("hidden")
          }
        })
      }
    }

    toggle_third_level(event) {
        const slug = event.currentTarget.dataset.slug

       if(this.hasThirdLevelTarget) {
          this.thirdLevelTargets.forEach((element) => {
            if(element.dataset.slug === slug) {
              if(element.classList.contains("hidden")) {
                element.classList.remove("hidden")
              } else {
                element.classList.add("hidden")
              }
            } else {
              element.classList.add("hidden")
            }
          })
        }
    }
}
