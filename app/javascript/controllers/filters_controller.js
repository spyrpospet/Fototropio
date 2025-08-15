import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filters"
export default class extends Controller {
  static targets = ["form", "filtersColumn", "productsColumn"]

  connect() {
  }

  submitForm(event) {
     this.formTarget.requestSubmit()
  }

  toggle_filter(event) {
    let sub = event.currentTarget.querySelector('.sub')

    if(sub.classList.contains('hidden')) {
      sub.classList.remove('hidden')
    } else {
        sub.classList.add('hidden')
    }
  }

}

