import { Controller } from "@hotwired/stimulus"
import { post } from "@rails/request.js"

// Connects to data-controller="preview"
export default class extends Controller {
  static targets = [ "source", "preview" ]

  connect() {
  }

  // Called when the source textarea is changed
  update() {
      // Get the file from the file input
      let file = this.sourceTarget.files[0];

      // Create a new FileReader object
      let reader = new FileReader();

      // Set the onload function for the FileReader
      reader.onloadend = () => {
        // Set the preview image's src to the result of the FileReader
        this.previewTarget.src = reader.result;
      }

      // If a file was selected, read it as a data URL
      if (file) {
        reader.readAsDataURL(file);
      } else {
        // If no file was selected, clear the preview image's src
        this.previewTarget.src = ""
      }
  }

  remove(event) {
    const category_id   = event.currentTarget.dataset.categoryId
    const id            = event.currentTarget.dataset.id

    post(`/administration/categories/remove-image`, {
      body: {
        id: id
      }
    }).then(() => {
        this.previewTarget.src = ""
    })
  }
}
