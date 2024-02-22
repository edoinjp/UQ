import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="vark"
export default class extends Controller {
  connect() {
    console.log("Test 2")
  }
}
