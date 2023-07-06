import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.scrollToBottom();
  }

  scrollToBottom() {
    const chatMessagesContainer = this.element;

    const observer = new MutationObserver((mutationsList, observer) => {
      for (let mutation of mutationsList) {
        if (mutation.type === "childList" && mutation.addedNodes.length > 0) {
          chatMessagesContainer.scrollTop = chatMessagesContainer.scrollHeight;
        }
      }
    });

    observer.observe(chatMessagesContainer, { childList: true });
  }
}













