import { Controller } from "@hotwired/stimulus";
import { Modal } from "bootstrap";

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["modal", "modalBody", "modalTitle", "modalFooter"];

  connect() {
    this.modalTitleTarget.textContent = this.data.get("title");
    this.modalBodyTarget.textContent = this.data.get("body");
    this.bootstrapModal = new Modal(this.modalTarget);

    this.showModal();
  }

  showModal() {
    this.bootstrapModal.show();
  }
}
