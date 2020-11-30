
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["counter", "basketButton", "submitButton", "input"]

  connect() {

  }

  clickBasket() {
    this.counterTarget.classList.remove("hidden");
    this.basketButtonTarget.classList.add("hidden");
    this.submitButtonTarget.classList.remove("hidden");
  }

  clickSubmit() {
    this.counterTarget.classList.add("hidden");
    this.basketButtonTarget.classList.remove("hidden");
    this.submitButtonTarget.classList.add("hidden");
  }

  decrease() {
    if (parseInt(this.inputTarget.value) <= 0) return ;

    this.inputTarget.stepDown();
  }

  increase() {
    this.inputTarget.stepUp();
  }
}
