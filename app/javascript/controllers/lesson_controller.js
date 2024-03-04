import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="lesson"
export default class extends Controller {
  static targets = ["mainContent", "supplementaryContent"]
  toggleSupplementaryContent() {
    this.mainContentTarget.classList.toggle("d-none");
    this.supplementaryContentTarget.classlist.toggle("d-none");
  }
}
