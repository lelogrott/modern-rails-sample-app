import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="autosubmit"
export default class extends Controller {
  static targets = ["submitbutton"]
  connect() {
    this.submitbuttonTarget.hidden = true;
  }
  submit() {
    // debounce strategy for autosubmit form
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      this.submitbuttonTarget.click();
    }, 500);
  }
}
