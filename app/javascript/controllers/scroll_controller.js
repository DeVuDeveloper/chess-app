import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["messages"];

  connect() {
    console.log("Connected to Stimulus controller.");
    this.scrollToBottom();
  }

  appendMessage(event) {
    console.log("Append message event fired.");
    const message = event.detail.templateElement.content.firstElementChild;
    this.messagesTarget.appendChild(message);
    this.scrollToBottom();
    console.log("Message appended to DOM.");
  }

  scrollToBottom() {
    console.log("Scrolling to bottom.");
    if (this.hasMessagesTarget) {
      this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight;
    }
  }
}








