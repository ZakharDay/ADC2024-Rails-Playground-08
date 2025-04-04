import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [
    'galleryImagesRail',
    'galleryImage',
    'prevButton',
    'nextButton',
    'newImageButton',
    'createImageButton',
    'galleryMeatballs',
    'galleryMeatball',
  ];

  static values = { index: Number };

  static classes = ['navButtonVisibility', 'meatballActive'];

  connect() {
    if (this.galleryImageTargets.length > 0) {
      this.renderSlides();
      this.renderNavigation();
      this.renderMeatballs();
    }
  }

  galleryImageTargetConnected() {
    this.renderNavigation();
  }

  galleryMeatballsTargetConnected() {
    if (this.galleryImageTargets.length > 0) {
      this.renderMeatballs();
    }
  }

  newImageFormTargetDisconnected() {
    console.log('newImageFormTargetDisconnected');

    if (this.galleryImageTargets.length) {
      this.moveToSlide({
        params: { position: this.galleryImageTargets.length - 1 },
      });
    }
  }

  indexValueChanged() {
    if (this.galleryImageTargets.length > 0) {
      this.renderSlides();
      this.renderNavigation();
      this.renderMeatballs();
    }
  }

  newImage() {
    this.newImageButtonTarget.click();
  }

  createImage() {
    this.createImageButtonTarget.click();
  }

  nextImage() {
    this.moveSlide('next');
  }

  prevImage() {
    this.moveSlide('prev');
  }

  moveToSlide({ params: { position } }) {
    this.indexValue = position;
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

  renderMeatballs() {
    console.log(
      'renderMeatballs',
      this.indexValue,
      this.galleryMeatballTargets.length
    );

    this.galleryMeatballTargets.forEach((meatball) => {
      meatball.classList.remove(this.meatballActiveClass);
    });

    const meatball = this.galleryMeatballTargets[this.indexValue];
    meatball.classList.add(this.meatballActiveClass);
  }
}
