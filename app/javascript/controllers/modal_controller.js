import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "form"]

  connect() {
    this.backgroundHtml = this.backgroundHTML()
    this.visible = false
  }

  disconnect() {
    if (this.visible) {
      this.close()
    }
  }

  open() {
    this.visible = true
    document.body.insertAdjacentHTML('beforeend', this.backgroundHtml)
    this.background = document.querySelector(`#modal-background`)
    this.background.addEventListener("click", () => {
      this.close()
    })
    this.toggleModal()
  }

  close() {
    this.visible = false
    this.toggleModal()
    if (this.background) {
      this.background.classList.remove("opacity-100")
      this.background.classList.add("opacity-0")
      setTimeout(() => {
        this.background.remove()
      }, 500);
    }
  }

  toggleModal() {
    this.modalTarget.classList.toggle("hidden")
  }

  backgroundHTML() {
    return `<div id="modal-background" class="fixed top-0 left-0 w-full h-full z-20"></div>`;
  }

  handleResponse({ detail: { success } }) {
    if (success) {
      this.formTarget.reset()
      this.close()
    }
  }
}