import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loader"
export default class extends Controller {
  connect() {
    console.log('Sup')
  }

  static targets = ["loadcircle"]

  spinner(event) {
    this.loadcircleTarget.classList.toggle("d-none");
  }
}
