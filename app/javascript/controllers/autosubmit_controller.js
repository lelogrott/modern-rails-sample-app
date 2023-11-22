import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="autosubmit"
export default class extends Controller {
  static targets = ["previewbutton"]
  connect() {
    this.previewbuttonTarget.hidden = true;
  }
  submit() {
    // debounce strategy for autosubmit form
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      this.previewbuttonTarget.click();
    }, 500);
  }
}
