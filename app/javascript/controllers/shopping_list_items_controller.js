import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="shopping-list-items"
export default class extends Controller {
  static targets = ["input", "results", "selectedItems", "selectedItemIdsContainer"];


  ASC = "asc";
  DESC = "desc";

  connect() {
    const shoppingListItems = JSON.parse(this.data.get("shoppingListItems"));

    console.log("shoppingListItems", shoppingListItems);

    if (shoppingListItems) {
      shoppingListItems.forEach((shoppingListItem) => {
        this.addSelectedItemButton(
          shoppingListItem.id,
          shoppingListItem.item_name
        );
      });
    }
  }

  shoppingListItemsSearch() {
    const query = this.inputTarget.value;
    this.resultsTarget.innerHTML = "";

    if (query.length > 1) {
      fetch(`/items/search?query=${query}`)
        .then((response) => response.text())
        .then((html) => {
          this.resultsTarget.innerHTML = html;
          this.checkAllSelectedItemsCheckboxes();
        });
    }
  }

  select(event) {
    const checkbox = event.target;
    const itemId = checkbox.value;
    const itemName = checkbox.dataset.itemName;

    if (checkbox.checked) {
      this.addSelectedItemButton(itemId, itemName);
    } else {
      this.removeSelectedItemButton(itemId, event);
    }
  }

  addSelectedItemButton(itemId, itemName) {
    this.addSelectedItemId(itemId);

    const selectedItemId = this.selectedItemIdFrom(itemId);

    const htmlString = `
      <div id="${selectedItemId}" class="selected-item btn-group" role="group">
        <div class="btn-group" role="group">
          <button type="button"
                  class="m-1 btn btn-sm btn-secondary dropdown-toggle"
                  data-bs-toggle="dropdown"
                  aria-expanded="false"
                  data-item-id="${itemId}">
            ${itemName}
          </button>
          <ul class="dropdown-menu">
            <li>
              <a class="dropdown-item"
                  href="#"
                  data-action="click->shopping-list-items#removeSelectedItem"
                  data-item-id="${itemId}">
                Remove
              </a>
            </li>
          </ul>
        </div>
      </div>
    `;

    this.selectedItemsTarget.innerHTML += htmlString;

    this.sortSelectedItemButtons(this.ASC);
  }

  removeSelectedItem(event) {
    this.removeSelectedItemButton(event.target.dataset.itemId, event);
    this.uncheckSelectedItemCheckbox(event.target.dataset.itemId);
  }

  removeSelectedItemButton(itemId, event) {
    this.removeSelectedItemId(itemId);

    const selectedItemId = this.selectedItemIdFrom(itemId);

    event.preventDefault();
    document.getElementById(selectedItemId)?.remove();
  }

  uncheckSelectedItemCheckbox(itemId) {
    const checkbox = document.getElementById(`item_ids_${itemId}`);

    if (!checkbox) return;

    checkbox.checked = false;
  }

  checkAllSelectedItemsCheckboxes() {
    const selectedItems = this.selectedItemsTarget.querySelectorAll("button");

    selectedItems.forEach((selectedItem) => {
      const itemId = selectedItem.dataset.itemId;
      const checkbox = document.getElementById(`item_ids_${itemId}`);

      if (!checkbox) return;

      checkbox.checked = true;
    });
  }

  addSelectedItemId(itemId) {
    const selectedItemIdsContainer = this.selectedItemIdsContainerTarget;

    selectedItemIdsContainer.innerHTML += `
      <input type="hidden"
             name="selected_item_ids[]"
             id="selected_item_id_${itemId}"
             value="${itemId}"
      >
    `;
  }

  removeSelectedItemId(itemId) {
    const selectedItemIdsContainer = this.selectedItemIdsContainerTarget;
    selectedItemIdsContainer.querySelector(`#selected_item_id_${itemId}`)?.remove();
  }

  selectedItemIdFrom(itemId) {
    return `selected-shopping-list-item-${itemId}`;
  }

  sortSelectedItemButtons(sortOrder) {
    const selectedItems = this.selectedItemsTarget.querySelectorAll(".selected-item");

    console.log("selectedItems", selectedItems);

    const sortedSelectedItems = Array.from(selectedItems).sort((a, b) => {
      const aButton = a.querySelector("button");
      const bButton = b.querySelector("button");
      if (sortOrder === this.ASC) {
        return aButton.innerText.localeCompare(bButton.innerText);
        //return a.innerText.localeCompare(b.innerText);
      } else {
        return bButton.innerText.localeCompare(aButton.innerText);
        //return b.innerText.localeCompare(a.innerText);
      }
    });

    this.selectedItemsTarget.innerHTML = "";

    sortedSelectedItems.forEach((selectedItem) => {
      this.selectedItemsTarget.appendChild(selectedItem);
    });
  }
}
