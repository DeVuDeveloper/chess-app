import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="games"

export default class extends Controller {
  connect() {
    this.element.addEventListener("ajax:success", this.handleCreateGameSuccess.bind(this));
  }

  handleCreateGameSuccess(event) {
    const [data, _status, xhr] = event.detail;
    const gameId = xhr.getResponseHeader("Game-Id");
    const turboFrame = document.getElementById("games");
    turboFrame.insertAdjacentHTML("afterbegin", data);
    this.resetForm();
  }

  resetForm() {
    const form = this.element;
    form.reset();
  }
}
