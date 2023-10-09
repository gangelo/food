import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="pager"
export default class extends Controller {
  static targets = ["pagerLinks"];

  connect() {
    this.element.querySelectorAll(this.noActionCssClass).forEach((link) => {
      link.addEventListener("click", this.preventDefault);
    });
  }

  disconnect() {
    this.element.querySelectorAll(this.noActionCssClass).forEach((link) => {
      link.removeEventListener("click", this.preventDefault);
    });
  }

  preventDefault(event) {
    event.preventDefault();
  }

  get noActionCssClass() {
    return `.${this.data.get("noActionCssClass")}`;
  }
}
