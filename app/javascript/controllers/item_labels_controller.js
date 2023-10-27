import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="item-labels"
export default class extends Controller {
  static targets = [
    "input",
    "results",
    "selectedLabels",
    "selectedLabelIdsContainer",
  ];

  ASC = "asc";
  DESC = "desc";

  connect() {
    const json = this.data.get("itemLabels");
    if (!json) return;

    console.log("json", json);

    const itemLabels = JSON.parse(json);

    console.log("itemLabels", itemLabels);

    if (itemLabels) {
      itemLabels.forEach((itemLabel) => {
        this.addSelectedLabelButton(itemLabel.id, itemLabel.label_name);
      });
    }
  }

  itemLabelsSearch() {
    const query = this.inputTarget.value;
    this.resultsTarget.innerHTML = "";

    if (query.length > 1) {
      fetch(`/labels/search?query=${query}`)
        .then((response) => response.text())
        .then((html) => {
          this.resultsTarget.innerHTML = html;
          this.checkAllSelectedLabelsCheckboxes();
        });
    }
  }

  select(event) {
    const checkbox = event.target;
    const labelId = checkbox.value;
    const itemName = checkbox.dataset.itemName;

    if (checkbox.checked) {
      this.addSelectedLabelButton(labelId, itemName);
    } else {
      this.removeSelectedLabelButton(labelId, event);
    }
  }

  addSelectedLabelButton(labelId, itemName) {
    this.addSelectedLabelId(labelId);

    const selectedLabelId = this.selectedLabelIdFrom(labelId);

    const htmlString = `
      <div id="${selectedLabelId}" class="selected-label btn-group" role="group">
        <div class="btn-group" role="group">
          <button type="button"
                  class="m-1 btn btn-sm btn-secondary dropdown-toggle"
                  data-bs-toggle="dropdown"
                  aria-expanded="false"
                  data-label-id="${labelId}">
            ${itemName}
          </button>
          <ul class="dropdown-menu">
            <li>
              <a class="dropdown-label"
                  href="#"
                  data-action="click->item-labels#removeSelectedLabel"
                  data-label-id="${labelId}">
                Remove
              </a>
            </li>
          </ul>
        </div>
      </div>
    `;

    this.selectedLabelsTarget.innerHTML += htmlString;

    this.sortSelectedLabelButtons(this.ASC);
  }

  removeSelectedLabel(event) {
    this.removeSelectedLabelButton(event.target.dataset.labelId, event);
    this.uncheckSelectedLabelCheckbox(event.target.dataset.labelId);
  }

  removeSelectedLabelButton(labelId, event) {
    this.removeSelectedLabelId(labelId);

    const selectedLabelId = this.selectedLabelIdFrom(labelId);

    event.preventDefault();
    document.getElementById(selectedLabelId)?.remove();
  }

  uncheckSelectedLabelCheckbox(labelId) {
    const checkbox = document.getElementById(`label_ids_${labelId}`);

    if (!checkbox) return;

    checkbox.checked = false;
  }

  checkAllSelectedLabelsCheckboxes() {
    const selectedLabels = this.selectedLabelsTarget.querySelectorAll("button");

    selectedLabels.forEach((selectedLabel) => {
      const labelId = selectedLabel.dataset.labelId;
      const checkbox = document.getElementById(`label_ids_${labelId}`);

      if (!checkbox) return;

      checkbox.checked = true;
    });
  }

  addSelectedLabelId(labelId) {
    const selectedLabelIdsContainer = this.selectedLabelIdsContainerTarget;
    const selectedLabelId = this.selectedLabelIdFrom(labelId);

    selectedLabelIdsContainer.innerHTML += `
      <input type="hidden"
             name="item_label[item_attributes][][label_id]"
             id="${selectedLabelId}"
             value="${labelId}"
      >
    `;
  }

  removeSelectedLabelId(labelId) {
    const selectedLabelIdsContainer = this.selectedLabelIdsContainerTarget;
    const selectedLabelId = this.selectedLabelIdFrom(labelId);
    selectedLabelIdsContainer.querySelector(`#${selectedLabelId}`)?.remove();
  }

  selectedLabelIdFrom(labelId) {
    return `item_labels_attributes_${labelId}_label_id`;
  }

  sortSelectedLabelButtons(sortOrder) {
    const selectedLabels =
      this.selectedLabelsTarget.querySelectorAll(".selected-label");

    console.log("selectedLabels", selectedLabels);

    const sortedSelectedLabels = Array.from(selectedLabels).sort((a, b) => {
      const aButton = a.querySelector("button");
      const bButton = b.querySelector("button");
      if (sortOrder === this.ASC) {
        return aButton.innerText.localeCompare(bButton.innerText);
      } else {
        return bButton.innerText.localeCompare(aButton.innerText);
      }
    });

    this.selectedLabelsTarget.innerHTML = "";

    sortedSelectedLabels.forEach((selectedLabel) => {
      this.selectedLabelsTarget.appendChild(selectedLabel);
    });
  }
}
