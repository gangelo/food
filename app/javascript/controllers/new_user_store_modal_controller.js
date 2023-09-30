// controllers/new_user_store_modal_controller.js
import ModalController from "./modal_controller";

export default class extends ModalController {
  static targets = [...ModalController.targets, "newUserStoreModal"];

  connect() {
    super.connect();

    console.log("Derived controller connected");

    this.modalButtonPrimaryTarget.addEventListener("click", () => {
      console.log("Primary button clicked");
    });
  }
}
