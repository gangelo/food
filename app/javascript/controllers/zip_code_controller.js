import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="zip-code"
export default class extends Controller {
  static targets = ["city", "state", "zipCode", "submitButton"];

  connect() {}

  async fetchCityAndStateFromZipCode(event) {
    let zipCode = event.target.value;
    zipCode = zipCode.replace(/\s+/g, ""); // Remove all whitespace
    this.zipCodeTarget.value = zipCode;

    this.clearAdjacentErrorDivs();
    this.showSpinner();
    this.cityTarget.value = "";
    this.stateTarget.options[0].selected = true;

    // Validate zipCode
    if (zipCode.length !== 5 || isNaN(zipCode)) {
      this.displayFetchError(`Zip code is invalid.`);
      this.hideSpinner();
      return;
    }

    try {
      let response = await fetch(`/api/zip_codes/zip_code_data/${zipCode}`);
      if (response.ok) {
        let data = await response.json();
        if (data.success) {
          // Check if the success property is true
          this.cityTarget.value = data.data.city; // Access city using data.data.city
          let stateLabel = `${data.data.state} (${data.data.state_abbreviation})`; // Use data.data.state and data.data.state_abbreviation
          for (let option of this.stateTarget.options) {
            if (option.text === stateLabel) {
              option.selected = true;
              break;
            }
          }
        } else {
          this.displayFetchError(
            `Failed to locate city and state for ${zipCode}.`
          );
        }
      } else {
        this.displayFetchError(
          `Failed to locate city and state for ${zipCode}.`
        );
      }
    } catch (error) {
      this.displayFetchError(
        `There was an error trying to locate city and state for ${zipCode}: ${error}`
      );
    }

    this.hideSpinner();
  }

  clearAdjacentErrorDivs() {
    this.zipCodeTarget.classList.remove("is-invalid");
    while (this.zipCodeTarget.nextElementSibling && this.zipCodeTarget.nextElementSibling.classList.contains('invalid-feedback')) {
        this.zipCodeTarget.nextElementSibling.remove();
    }
}

  displayFetchError(error) {
    // Add a Bootstrap "is-invalid" class to the inputs
    this.zipCodeTarget.classList.add("is-invalid");

    // Add an error div with the error message
    this.zipCodeTarget.insertAdjacentHTML(
      "afterend",
      `<div class="invalid-feedback">${error}</div>`
    );
  }

  showSpinner() {
    // Add the Bootstrap "disabled" class to the inputs
    this.submitButtonTarget.disabled = true;
    this.cityTarget.disabled = true;
    this.stateTarget.disabled = true;
    this.zipCodeTarget.disabled = true;

    // Optionally, add a spinner (for demonstration, I'm using a simple inline text spinner).
    // You can replace this with an actual spinner image or icon from Bootstrap.
    this.cityTarget.placeholder = "Loading...";
  }

  hideSpinner() {
    // Remove the Bootstrap "disabled" class from the inputs
    this.submitButtonTarget.disabled = false;
    this.cityTarget.disabled = false;
    this.stateTarget.disabled = false;
    this.zipCodeTarget.disabled = false;

    // Remove the spinner (clear the placeholder in this case)
    this.cityTarget.placeholder = "";
  }
}
