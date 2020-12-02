
import { Controller } from "stimulus"
import { fetchWithToken } from "../utils/fetch_with_token";


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
    if (parseInt(this.inputTarget.value) === 0) {
      const orderLineId = this.inputTarget.dataset.orderLineId

      fetchWithToken(`/order_lines/${orderLineId}`, {
        method: "DELETE",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
      })
        .then(response => response.json())
        .then((data) => {
          console.log(data)
          // handle JSON response from server
          const cartlistDiv = document.getElementById("cartlist")
          cartlistDiv.innerHTML = data.cartlist
        });
    } else {
      const productId = this.inputTarget.dataset.productId

      fetchWithToken(`/products/${productId}/order_lines`, {
        method: "POST",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: JSON.stringify({ order_line: { quantity: this.inputTarget.value }})
      })
        .then(response => response.json())
        .then((data) => {
          console.log(data)
          // handle JSON response from server
          const cartlistDiv = document.getElementById("cartlist")
          cartlistDiv.innerHTML = data.cartlist
        });
    }
  }

  increase() {
    this.inputTarget.stepUp();

    const productId = this.inputTarget.dataset.productId

    fetchWithToken(`/products/${productId}/order_lines`, {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ order_line: { quantity: this.inputTarget.value }})
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
        // handle JSON response from server
        this.inputTarget.dataset.orderLineId = data.order_line_id

        const cartlistDiv = document.getElementById("cartlist")
        cartlistDiv.innerHTML = data.cartlist
      });
  }
}
