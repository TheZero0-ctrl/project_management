import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = [ "menu" ]
  connect() {
  }

  toggle() {
    this.menuTarget.classList.toggle("hidden")
  }

  close() {
    if (window.innerWidth > 1024 && !this.menuTarget.classList.contains("hidden")) {
      this.menuTarget.classList.toggle("hidden")
    }
  }
}
