import { Controller } from "@hotwired/stimulus"
import { post } from '@rails/request.js'

// Connects to data-controller="search"
export default class extends Controller {
  static targets = [ "form", "container", "results" ]

  connect() {
  }

  formSubmit(event) {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
        this.formTarget.requestSubmit()
    }, 800)
  }

  close(event) {
    this.containerTarget.classList.add('hidden')
    this.resultsTarget.innerHTML = ''
  }

  open(event) {
    this.containerTarget.classList.remove('hidden')
  }
}
