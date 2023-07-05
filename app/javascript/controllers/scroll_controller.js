import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Connected to Scroll controller.");
    this.scrollToBottom();
  }

  scrollToBottom() {
    const chatMessagesContainer = this.element;
    console.log('chatMessagesContainer:', chatMessagesContainer);
    console.log('scrollHeight:', chatMessagesContainer.scrollHeight);

    const observer = new MutationObserver((mutationsList, observer) => {
      for (let mutation of mutationsList) {
        if (mutation.type === "childList" && mutation.addedNodes.length > 0) {
          chatMessagesContainer.scrollTop = chatMessagesContainer.scrollHeight;
          console.log("New scroll position:", chatMessagesContainer.scrollTop);
        }
      }
    });

    observer.observe(chatMessagesContainer, { childList: true });
  }
}













