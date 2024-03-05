import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["mainContent", "supplementaryContent"]

  toggleSupplementaryContent(event) {
    const isChecked = event.target.checked;

    if (isChecked) {
      this.mainContentTarget.classList.add("d-none");
      this.supplementaryContentTarget.classList.remove("d-none");
    } else {
      this.mainContentTarget.classList.remove("d-none");
      this.supplementaryContentTarget.classList.add("d-none");
    }
  }
}
