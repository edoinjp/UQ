import { Controller } from "@hotwired/stimulus"
import Reveal from "reveal.js"
import RevealMarkdown from "https://cdn.jsdelivr.net/npm/reveal.js/plugin/markdown/markdown.esm.js"

// Connects to data-controller="slides"
export default class extends Controller {
  connect() {
    console.log("ki");
    const deck = new Reveal(this.element ,{
      plugins: [ RevealMarkdown ]
    })
    deck.initialize({
      embedded: true,
      maxScale: 1,
    })
    // Change the size of our presentation
    this.element.style.width = '720px';
    this.element.style.height = '400px';
    // Make reveal.js aware of the size change
    deck.layout();
}
}
