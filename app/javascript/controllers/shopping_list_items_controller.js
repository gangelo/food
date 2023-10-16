import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="shopping-list-items"
export default class extends Controller {
  static targets = ["input", "results", "selectedItems"];

  connect() {
  }

  search() {
    const query = this.inputTarget.value;
    fetch(`/items/search?query=${query}`)
      .then((response) => response.text())
      .then((html) => {
        this.resultsTarget.innerHTML = html;
        this.checkSelectedItems();
      });
  }

  select(event) {
    const checkbox = event.target;
    const itemId = checkbox.value;
    const itemName = checkbox.dataset.itemName;

    if (checkbox.checked) {
      this.addItem(itemId, itemName);
    } else {
      this.removeItem(itemId);
    }
  }

  addItem(itemId, itemName) {
    const selectedItemId = this.selectedItemIdFrom(itemId);

    const htmlString = `
      <div id="${selectedItemId}" class="btn-group" role="group">
        <div class="btn-group" role="group">
          <button type="button"
                  class="m-1 btn btn-sm btn-primary dropdown-toggle"
                  data-bs-toggle="dropdown"
                  aria-expanded="false"
                  data-item-id="${itemId}">
            ${itemName}
          </button>
          <ul class="dropdown-menu">
            <li>
              <a class="dropdown-item"
                  href="#"
                  data-action="click->shopping-list-items#removeItemEvent"
                  data-item-id="${itemId}">
                Remove
              </a>
            </li>
          </ul>
        </div>
      </div>
    `;

    this.selectedItemsTarget.innerHTML += htmlString;
  }

  removeItemEvent(event) {
    this.removeItem(event.target.dataset.itemId);
    this.uncheckSelectedItem(event.target.dataset.itemId);
  }

  removeItem(itemId) {
    const selectedItemId = this.selectedItemIdFrom(itemId);

    event.preventDefault();
    document.getElementById(selectedItemId)?.remove();
  }

  uncheckSelectedItem(itemId) {
    const checkbox = document.getElementById(`item_ids_${itemId}`);

    if (!checkbox) return;

    checkbox.checked = false;
  }

  checkSelectedItems() {
    const selectedItems = this.selectedItemsTarget.querySelectorAll("button");

    selectedItems.forEach((selectedItem) => {
      const itemId = selectedItem.dataset.itemId;
      const checkbox = document.getElementById(`item_ids_${itemId}`);

      if (!checkbox) return;

      checkbox.checked = true;
    });
  }

  selectedItemIdFrom(itemId) {
    return `selected-shopping-list-item-${itemId}`;
  }
}
