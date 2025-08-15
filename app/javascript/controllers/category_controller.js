import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="category"
export default class extends Controller {
  connect() {
    this.init_choices()
  }

    init_choices() {
      const element = document.querySelector('.js-choice');

      if (!element) return

      const choices = new Choices(element);
    }
}
