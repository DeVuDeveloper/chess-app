import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["messages"];

  connect() {
    console.log("connected");
    this.scrollBottom();
  }

  appendMessage(event) {
    const message = event.detail.templateElement.content.firstElementChild;
    this.messagesTarget.appendChild(message);
    this.scrollBottom();
  }

  scrollBottom() {
    if (this.messagesTarget) {
      this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight;
    }
  }
}


