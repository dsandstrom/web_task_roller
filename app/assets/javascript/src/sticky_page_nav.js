export class StickyPageNav {
  constructor(nav) {
    this.elem = nav;
    this.parentElem = nav.parentElement;
    this.top = window.scrollY + this.elem.getBoundingClientRect().top;
    this.height = this.elem.offsetHeight;
    if (!this.elem || !this.parentElem || !this.height) return;

    this.watchScroll();
  }

  watchScroll() {
    const elem = this.elem;
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
