// controllers/new_user_store_modal_controller.js
import ModalController from "./modal_controller";

export default class extends ModalController {
  static targets = [...ModalController.targets, "newUserStoreModal"];

  connect() {
    super.connect();

    this.modalButtonPrimaryTarget.addEventListener("click", () => {
      let formId = this.data.get("formId");
      document.getElementById(formId).submit();
    });
  }
}
