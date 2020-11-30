import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "address", "transportation" ]

  connect() {

  }

  triggerMap(event) {
    const address = this.addressTarget.value
    console.log(address)

    // const transportation = this.currentTarget.text
    const transportation = event.currentTarget.getAttribute("for")
    console.log(transportation)
  }

  // this.stimulate("Map#nearby", address)
}
