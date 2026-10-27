export class StickyPageNav {
  constructor(nav, main) {
    this.nav = nav;
    this.main = main;
    if (!this.nav || !this.main) return;

    this.parentElem = this.nav.parentElement;
    this.top = window.scrollY + this.nav.getBoundingClientRect().top;
    this.height = this.nav.offsetHeight;
    if (!this.parentElem || !this.top || !this.height) return;

    this.initialize();
    this.watchScroll();
    this.setupTopLink();
  }

  hideTopLinks() {
    for (const topLink of this.main.querySelectorAll('.top-link-wrapper')) {
      topLink.classList.add('hide');
    }
  }

  setupTopLink() {
    this.hideTopLinks();

    const topLink = this.nav.querySelector('.top-link-wrapper a');
    if (!topLink) return;

    topLink.addEventListener('click', function(event) {
      event.preventDefault();
      window.scrollTo({ top: 0, behavior: "smooth" });
    });
  }

  toggle(elem, parentElem, top, height) {
    if (window.pageYOffset > top) {
      elem.classList.add('sticky');
      parentElem.style.marginTop = height + 'px';
    } else {
      elem.classList.remove('sticky');
      parentElem.style.marginTop = 0;
    }
  }

  initialize() {
    const elem = this.nav;
    const parentElem = this.parentElem;
    const top = this.top;
    const height = this.height;

    this.toggle(elem, parentElem, top, height);
  }

  watchScroll() {
    const elem = this.nav;
    const parentElem = this.parentElem;
    const top = this.top;
    const height = this.height;
    const toggle = this.toggle;

    document.addEventListener('scroll', function(){
      toggle(elem, parentElem, top, height);
    });
  }
};
