import { Controller } from "@hotwired/stimulus"
import { post } from "@rails/request.js"
import { Fancybox } from "vendor/fancybox.esm"
import "vendor/sortable.min"

// Connects to data-controller="product"
export default class extends Controller {
  static targets = ["optionList","imagesInput", "item", "itemList"]

  connect() {
    this.init_choices()
    this.init_fancybox()
    this.init_sortable()
  }

  init_sortable() {
    const element = document.querySelector('#product-images')

    if (!element) return

    const sortable = new Sortable(element, {
        animation: 150,
        onEnd: (event) => {
                // get the new order or items
                let new_order   = []
                const id        = element.querySelector('.product-image').dataset.productId

                element.querySelectorAll('.product-image').forEach((item, index) => {
                    new_order.push(item.dataset.imageId)
                })

                post(`/administration/products/${id}/move`, {
                    body: {new_order: new_order}
                })
            }
    })
  }

  init_fancybox() {
    const fancybox_items = document.querySelectorAll("[data-fancybox]");

    if(!fancybox_items) return

    Fancybox.bind("[data-fancybox]");
  }

  init_choices() {
    const element = document.querySelector('.js-choice');

    if (!element) return

    const choices = new Choices(element);
  }

  add_new_option(event) {
    event.preventDefault()

    const option_id  = this.optionListTarget.selectedOptions[0].value

    post(`/administration/products/add-new-option`, {
        body: {option_id: option_id},
        responseKind: 'turbo-stream'
    })
  }

  remove_option(event) {
    event.preventDefault()
    let destroy_field = event.currentTarget.closest('.item').querySelector('.destroy')

    if (destroy_field){
        destroy_field.value = 1
        event.currentTarget.closest('.item').style.display = 'none'
    } else {
        event.currentTarget.closest('.item').remove()
    }
  }

  add_new_item(event) {
    event.preventDefault()

    const dom_id    = event.currentTarget.dataset.domId
    const option_id = event.currentTarget.dataset.optionId

    post(`/administration/products/add-new-option-item`, {
        body: {dom_id: dom_id, option_id: option_id},
        responseKind: 'turbo-stream'
    })
  }

  remove_item(event) {
    event.preventDefault()
    let destroy_field = event.currentTarget.closest('.item').querySelector('.destroy')

    if (destroy_field){
        destroy_field.value = 1
        event.currentTarget.closest('.item').style.display = 'none'
    } else {
        event.currentTarget.closest('.item').remove()
    }
  }

  open_images_input(event) {
    event.preventDefault()
    this.imagesInputTarget.click()
  }

  select_item(event) {
      let input = event.currentTarget.closest('.item').querySelector('input')

      this.itemTargets.forEach((item) => {
        item.querySelector("a").classList.remove("active")
        item.querySelector('input').checked = false
      })

       event.currentTarget.classList.add("active")
       input.checked = true
  }

  clear_options(event) {
    event.preventDefault()

    this.itemTargets.forEach((item) => {
       item.querySelector("a").classList.remove("active")
       item.querySelector('input').checked = false
    })
  }

  add_to_cart(event) {
    gtag('event', 'conversion', {'send_to': 'AW-10870981335/r6LBCPfOhJYZENeF2L8o'});
    fbq('track', 'AddToCart');
  }
}
