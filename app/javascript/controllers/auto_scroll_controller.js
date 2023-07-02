import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["list"];
  
    connect() {
      this.scrollDown();
    }
  
    scrollDown() {
      this.listTarget.scrollTop = this.listTarget.scrollHeight;
    }
  }