import { Controller } from "stimulus";

export default class extends Controller {
  static classes = ["show", "hide"];
  static targets = [ "menu" ]

  connect() {
    this.menuTarget.classList.add(this.hideClass);
  }

  toggle() {
    if (this.menuTarget.classList.value === "hidden") {
      this.menuTarget.classList.add(this.showClass);
      this.menuTarget.classList.remove(this.hideClass);
    } else {
      this.menuTarget.classList.remove(this.showClass);
      this.menuTarget.classList.add(this.hideClass);
    }
  }
}
