import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["mainContent", "supplementaryContent"]

  connect() {
    this.toggleState = sessionStorage.getItem('supplementaryToggle') === 'true';
    this.updateContentVisibility();
  }

  toggleSupplementaryContent(event) {
    // Prevent the default anchor behavior
    event.preventDefault();
    // Toggle the state
    this.toggleState = !this.toggleState;
    // Save the new state in session storage
    sessionStorage.setItem('supplementaryToggle', this.toggleState.toString());
    // Update the visibility of content based on the new state
    this.updateContentVisibility();
  }

  updateContentVisibility() {
    if (this.toggleState) {
      this.mainContentTarget.classList.add("d-none");
      this.supplementaryContentTarget.classList.remove("d-none");
    } else {
      this.mainContentTarget.classList.remove("d-none");
      this.supplementaryContentTarget.classList.add("d-none");
    }
  }
}
