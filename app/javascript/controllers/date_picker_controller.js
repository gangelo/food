import { Controller } from "@hotwired/stimulus";
import $ from "jquery";
import "bootstrap-datepicker";

// Connects to data-controller="date-picker"
export default class extends Controller {
  connect() {
    this.initializeDatepicker();
  }

  initializeDatepicker() {
    // Ensure the jQuery and datepicker library are loaded
    if (typeof $ !== "undefined" && $.fn && $.fn.datepicker) {
      let cssClass = ".datepicker";

      $(this.element.querySelectorAll(cssClass)).datepicker({
        todayBtn: true,
        daysOfWeekHighlighted: "0,6",
        todayHighlight: true,
        // defaultViewDate: { year: "1977", month: "04", day: "25" },
      });
    } else {
      console.error("Datepicker library is not loaded.");
    }
  }
}
