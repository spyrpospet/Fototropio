import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="common"
export default class extends Controller {
  connect() {
    document.addEventListener('turbo:frame-render', this.scroll_to_filters_top.bind(this))
  }

  scroll_to_element(element) {
    element.scrollIntoView({ behavior: 'smooth', block: "center", inline: "center" })
  }

  scroll_to_filters_top() {
   const top = document.querySelector('#filters-top')

   if (top) {
     this.scroll_to_element(top)
   }
  }
}
