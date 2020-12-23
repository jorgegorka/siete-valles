import { Controller } from "stimulus";

export default class extends Controller {
  static classes = ["show", "hide"];

  connect() {
    this.element.classList.add(this.showClass);
    setTimeout(() => {
      this.hide();
    }, 3000);
  }

  hide() {
    this.element.classList.remove(this.showClass);
    this.element.classList.add(this.hideClass);
  }
}
