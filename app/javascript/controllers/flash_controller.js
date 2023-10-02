import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="flash"
export default class extends Controller {
  static targets = ["container", "icon", "body", "close"];

  connect() {
    this.flashJson = this.data.get("flashJson");
    console.log("flashJson:", this.flashJson);

    if (Object.keys(this.flashJson).length === 0) {
      return;
    }

    let params = this.flashParams();
    this.containerTarget.classList.add(params.alertClass);
    this.iconTarget.classList.add(params.iconClass);
    this.bodyTarget.innerText = params.message;
    this.closeTarget.classList.add(params.closeClass);

    this.containerTarget.classList.remove("d-none");
    this.containerTarget.classList.add("show");

    this.closeTarget.addEventListener("click", () => {
      this.containerTarget.classList.remove("show"); // Start the fade out
      setTimeout(() => {
        this.containerTarget.classList.add("d-none"); // Hide it after the fade is done
      }, 150); // The fade duration is 150ms by default in Bootstrap 4/5
    });

  }

  flashParams() {
    let flashJson = this.flashJson;

    if (flashJson.notice) {
      return {
        alertClass: "alert-success",
        iconClass: "bi-check-circle-fill",
        message: flashJson.notice,
        closeClass: "bi-x-circle-fill",
      };
    } else if (flashJson.warn) {
      return {
        alertClass: "alert-warning",
        iconClass: "bi-exclamation-triangle-fill",
        message: flashJson.warn,
        closeClass: "bi-x-circle-fill",
      };
    } else if (flashJson.alert) {
      return {
        alertClass: "alert-danger",
        iconClass: "bi-exclamation-octagon-fill",
        message: flashJson.alert,
        closeClass: "bi-x-circle-fill",
      };
    } else if (flashJson.info) {
      return {
        alertClass: "alert-info",
        iconClass: "bi-info-circle-fill",
        message: flashJson.info,
        closeClass: "bi-x-circle-fill",
      };
    }
  }

  get flashJson() {
    return this._flashJson;
  }

  set flashJson(value) {
    this._flashJson = JSON.parse(value);
  }
}
