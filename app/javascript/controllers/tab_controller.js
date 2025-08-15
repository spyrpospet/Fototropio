import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tab"
export default class extends Controller {
  static targets = [ "tab", "heads", "contents" ]

  connect() {
  }

  remove_tab(event) {
    event.preventDefault()
    let destroy_field = event.currentTarget.closest('.item').querySelector('.destroy')

    if (destroy_field){
        destroy_field.value = 1
        event.currentTarget.closest('.item').style.display = 'none'
    } else {
        event.currentTarget.closest('.item').remove()
    }
  }

  show_tab_content(event) {
    event.preventDefault()

    this.headsTargets.forEach((head) => {
      head.classList.remove('active')
    })

    event.currentTarget.classList.add('active')

    let head = event.currentTarget
    let slug = head.dataset.slug

    this.contentsTargets.forEach((content) => {
      content.classList.add('hidden')
    })

    this.contentsTargets.forEach((content) => {
      if (content.dataset.slug == slug) {
        content.classList.remove('hidden')
      }
    })
  }
}
