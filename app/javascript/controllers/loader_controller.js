import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loader"
export default class extends Controller {
  connect() {
    console.log('Sup')
  }

  static targets = ["loadcircle", "loadlabel"]

  spinner(event) {
    this.loadcircleTarget.classList.toggle("d-none");

    setTimeout(() => {
      this.loadlabelTarget.innerText="Loading Visual Lesson..."
    }, 1000);

    setTimeout(() => {
      this.loadlabelTarget.innerText="Loading Aural Lesson..."
    }, 20000);

    setTimeout(() => {
      this.loadlabelTarget.innerText="Loading Reading Lesson..."
    }, 30000);

    setTimeout(() => {
      this.loadlabelTarget.innerText="Loading Kinesthetic Lesson..."
    }, 40000);
  }
}
