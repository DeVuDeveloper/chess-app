import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.showMessage();
  }

  showMessage() {
    let index = 0;
    const messageContainer = this.element;
    const messageContent = messageContainer.textContent.trim();
    messageContainer.textContent = '';

    const typingInterval = setInterval(() => {
      if (index < messageContent.length) {
        const char = messageContent.charAt(index);
        const newContent = document.createTextNode(char);
        messageContainer.appendChild(newContent);
        index++;
      } else {
        clearInterval(typingInterval);
      }
    }, 100);
  }
}
