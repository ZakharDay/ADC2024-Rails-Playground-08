import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [
    'galleryImagesRail',
    'prevButton',
    'nextButton',
    'galleryImage',
  ];

  static values = { index: Number };

  static classes = ['navButtonVisibility'];

  connect() {
    this.renderSlides();
    this.renderNavigation();
  }

  nextImage() {
    this.moveSlide('next');
  }

  prevImage() {
    this.moveSlide('prev');
  }

  moveSlide(direction) {
    if (direction === 'next') {
      if (this.indexValue + 1 < this.galleryImageTargets.length) {
        this.indexValue++;
      }
    }

    if (direction === 'prev') {
      if (this.indexValue >= 1) {
        this.indexValue--;
      }
    }
  }

  indexValueChanged() {
    this.renderSlides();
    this.renderNavigation();
  }

  renderSlides() {
    this.galleryImagesRailTarget.style.transform = `translateX(-${
      100 * this.indexValue
    }%)`;
  }

  renderNavigation() {
    if (this.indexValue === 0) {
      this.prevButtonTarget.classList.remove(this.navButtonVisibilityClass);
    }

    if (this.indexValue > 0) {
      this.prevButtonTarget.classList.add(this.navButtonVisibilityClass);
    }

    if (this.indexValue + 1 < this.galleryImageTargets.length) {
      this.nextButtonTarget.classList.add(this.navButtonVisibilityClass);
    }

    if (this.indexValue + 1 >= this.galleryImageTargets.length) {
      this.nextButtonTarget.classList.remove(this.navButtonVisibilityClass);
    }
  }
}
