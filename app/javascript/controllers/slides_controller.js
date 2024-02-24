import { Controller } from "@hotwired/stimulus"
import Reveal from "reveal.js"
import RevealMarkdown from "https://cdn.jsdelivr.net/npm/reveal.js/plugin/markdown/markdown.esm.js"

// Connects to data-controller="slides"
export default class extends Controller {
  connect() {
    const deck = new Reveal({
      plugins: [RevealMarkdown]
  })
  deck.initialize({ embedded: true,
  width: 720,
  height: 300,
  // margin: 0.2,
  maxScale: 0.5
})
  // Change the size of our presentation
  document.querySelector( '.reveal' ).style.width = '720px';
  document.querySelector( '.reveal' ).style.height = '400px';
  // Make reveal.js aware of the size change
  deck.layout();
}}
