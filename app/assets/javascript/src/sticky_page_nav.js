export class StickyPageNav {
  constructor(nav, main) {
    this.nav = nav;
    this.main = main;
    if (!this.nav || !this.main) return;

    this.parentElem = this.nav.parentElement;
    this.top = window.scrollY + this.nav.getBoundingClientRect().top;
    this.height = this.nav.offsetHeight;
    if (!this.parentElem || !this.top || !this.height) return;

    this.hideTopLinks();
    this.watchScroll();
  }

  hideTopLinks() {
    for (const topLink of this.main.querySelectorAll('.top-link-wrapper')) {
      topLink.classList.add('hide');
    }
  }

  watchScroll() {
    const elem = this.nav;
    const parentElem = this.parentElem;
    const top = this.top;
    const height = this.height;

    document.addEventListener('scroll', function(){
      if (window.pageYOffset > top) {
        elem.classList.add('sticky');
        parentElem.style.marginTop = height + 'px';
      } else {
        elem.classList.remove('sticky');
        parentElem.style.marginTop = 0;
      }
    });
  }
};
