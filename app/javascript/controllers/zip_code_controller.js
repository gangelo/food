import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="zip-code"
export default class extends Controller {
  static targets = ["city", "state"];

  connect() {
    console.log("ZipCodeController connected!");
  }

  async fetchCityAndState(event) {
    console.log(
      "ZipCodeController#fetchCityAndState",
      "fetching city and state..."
    );

    let zipCode = event.target.value;

    try {
      let response = await fetch(`http://api.zippopotam.us/us/${zipCode}`);
      if (response.ok) {
        let data = await response.json();
        this.cityTarget.value = data.places[0]["place name"];
        let stateLabel = `${data.places[0]["state"]} (${data.places[0]["state abbreviation"]})`;
        for (let option of this.stateTarget.options) {
          if (option.text === stateLabel) {
            option.selected = true;
            break;
          }
        }
      } else {
        console.error("Failed to fetch city and state.");
      }
    } catch (error) {
      console.error("There was an error:", error);
    }
  }
}
