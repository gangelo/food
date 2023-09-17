// https://stackoverflow.com/questions/75742517/how-to-highlight-active-nav-link-when-using-hotwire
// https://stimulus.hotwired.dev/reference/controllers
import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="nav-bar"
export default class extends Controller {
  connect() {}

  navigate(e) {
    //debugger;
    console.log("NavBarController#navigate", e.target);
    const activeButton = this.element.querySelector(".active");

    if (activeButton) {
      activeButton.classList.remove("disabled");
    }

    e.target.classList.add("disabled");
    e.target.classList.add("active");
  }
}
