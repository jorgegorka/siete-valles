import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["modal"];

  connect() {
    //
  }

  new() {
    const modalController = this.application.getControllerForElementAndIdentifier(
      this.modalTarget,
      "modal"
    );

    modalController.open();
  }

  edit(event) {
    event.preventDefault();
    const modalController = this.application.getControllerForElementAndIdentifier(
      this.modalTarget,
      "modal"
    );

    modalController.open();
  }

  sendReward() {
    const modalController = this.application.getControllerForElementAndIdentifier(
      this.modalTarget,
      "modal"
    );

    modalController.close();
  }
}
