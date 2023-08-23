import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['output'];

  connect() {
    if (!this.isMessageViewed()) {
      this.originalText = this.outputTarget.textContent.trim();
      this.outputTarget.textContent = '';
      this.typingText();
    }
  }

  isMessageViewed() {
    const viewed = this.outputTarget.dataset.viewed;
    return viewed === 'true';
  }

  typingText() {
    let currentIndex = 0;
    const typingInterval = setInterval(() => {
      const currentText = this.originalText.slice(0, currentIndex);
      this.outputTarget.textContent = currentText;
      currentIndex++;

      if (currentIndex > this.originalText.length) {
        clearInterval(typingInterval);
      }
    }, 10);
  }
}
