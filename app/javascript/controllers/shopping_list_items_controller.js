import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="shopping-list-items"
export default class extends Controller {
  static targets = ["input", "results", "selectedItems"];

  connect() {
    // this.initializeSelect();
  }

  initializeSelect() {
    // Ensure the jQuery and datepicker library are loaded
    if (typeof $ !== "undefined" && $.fn && $.fn.select2) {
      let cssClass = ".select2";

      $(this.element.querySelectorAll(cssClass)).select2({
        ajax: {
          url: self.data.get("url"),
          dataType: "json",
        },
      });
    } else {
      console.error("select2 library is not loaded.");
    }
  }

  search() {
    const query = this.inputTarget.value;
    fetch(`/items/search?query=${query}`)
      .then((response) => response.text())
      .then((html) => {
        this.resultsTarget.innerHTML = html;
      });
  }

  select(event) {
    const checkbox = event.target;
    const itemId = checkbox.value;
    const itemName = checkbox.dataset.itemName;

    console.log(
      "ShoppingListItemsController#select: checkbox checked: ",
      checkbox,
      itemId,
      itemName
    );

    if (checkbox.checked) {
      this.addSelectedItem(itemId, itemName);
    } else {
      this.removeSelectedItem(itemId);
    }
  }

  addSelectedItem(itemId, itemName) {
    const buttonGroupContainer = this.createButtonGroupContainer();
    this.selectedItemsTarget.appendChild(buttonGroupContainer);

    const buttonGroupDropdownContainer =
      this.createButtonGroupDropdownContainer(buttonGroupContainer);
    buttonGroupContainer.appendChild(buttonGroupDropdownContainer);

    const buttonItem = document.createElement("button");
    buttonItem.textContent = itemName;
    buttonItem.classList.add(
      "m-1",
      "btn",
      "btn-sm",
      "btn-primary",
      "dropdown-toggle"
    );
    buttonItem.dataset.itemId = itemId;
    buttonItem.setAttribute('data-bs-toggle', 'dropdown');
    buttonItem.setAttribute('aria-expanded', 'false');
    buttonGroupDropdownContainer.appendChild(buttonItem);

    const dropdownList = document.createElement("ul");
    dropdownList.classList.add("dropdown-menu");
    buttonGroupDropdownContainer.appendChild(dropdownList);

    const listItem = document.createElement("li");
    dropdownList.appendChild(listItem);

    const dropdownLink = document.createElement("a");
    dropdownLink.classList.add("dropdown-item");
    dropdownLink.href = "#";
    dropdownLink.textContent = "Remove";
    listItem.appendChild(dropdownLink);

    dropdownLink.addEventListener("click", (event) => {
      event.preventDefault();
      buttonGroupContainer.remove();
    });
  }

  createButtonGroupContainer() {
    const buttonGroupContainer = document.createElement("div");
    buttonGroupContainer.classList.add("btn-group");
    buttonGroupContainer.setAttribute("role", "group");
    return buttonGroupContainer;
  }

  createButtonGroupDropdownContainer(buttonGroupContainer) {
    const buttonGroupDropdownContainer = document.createElement("div");
    buttonGroupDropdownContainer.classList.add("btn-group");
    buttonGroupDropdownContainer.setAttribute("role", "group");
    return buttonGroupDropdownContainer;
  }

  removeSelectedItem(itemId) {
    const buttonItem = this.selectedItemsTarget.querySelector(
      `[data-item-id="${itemId}"]`
    );
    buttonItem.remove();
  }
}
