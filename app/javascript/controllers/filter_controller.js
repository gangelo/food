import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="filter"
export default class extends Controller {
  connect() {
    console.log("NOTE: FilterController loaded but is still WIP");

    let nameType = this.element.querySelector('[data-type="name"]');
    let streetType = this.element.querySelector('[data-type="street"]');
    let cityType = this.element.querySelector('[data-type="city"]');
    let stateType = this.element.querySelector('[data-type="state"]');
    let zipCodeType = this.element.querySelector('[data-type="zipCode"]');
  }
}
