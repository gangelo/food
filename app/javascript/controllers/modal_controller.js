import { Controller } from "@hotwired/stimulus";
import { Modal } from "bootstrap";

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["modal", "modalBody", "modalButtonPrimary", "modalButtonSecondary",
    "modalTitle", "modalFooter"];

  connect() {
    // NOTE: Use caution when using the data attribute API in concert with
    // any call to element.innerHTML as this is vulnerable to XSS attacks!
    this.modalTitleTarget.innerHTML = this.data.get("title");
    this.modalBodyTarget.innerHTML = this.data.get("body");
    this.modalButtonPrimaryTarget.innerHTML = this.data.get("buttonPrimary");
    this.modalButtonSecondaryTarget.innerHTML =
      this.data.get("buttonSecondary");
    this.bootstrapModal = new Modal(this.modalTarget);

    this.showModal();
  }

  showModal() {
    this.bootstrapModal.show();
  }
}
