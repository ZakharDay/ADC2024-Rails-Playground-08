import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['slide'];
  static values = { index: Number };

  next() {
    this.indexValue++;
  }

  previous() {
    this.indexValue--;
  }

  slideTargetConnected() {
    console.log('Slideshow Controller Slide Target Connected');
  }

  indexValueChanged() {
    this.showCurrentSlide();
  }

  showCurrentSlide() {
    this.slideTargets.forEach((element, index) => {
      element.hidden = index !== this.indexValue;
    });
  }
}
