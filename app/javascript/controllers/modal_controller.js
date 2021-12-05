import { Controller } from "stimulus";

export default class extends Controller {
  static classes = ["show", "hide"];

  connect() {
    this.element.classList.add(this.hideClass);
  }

  open() {
    this.element.classList.remove(this.hideClass);
    this.element.classList.add(this.showClass);
  }

  close() {
    this.element.classList.remove(this.showClass);
    this.element.classList.add(this.hideClass);
  }

  ignore(event) {
    event.stopPropagation();
  }
}
