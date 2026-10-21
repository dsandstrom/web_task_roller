import {StickyPageNav} from './../src/sticky_page_nav';
import {ReactivePageNav} from './../src/reactive_page_nav';

window.addEventListener("load", (event) => {
  const pageNav = document.getElementById('page_nav');
  const main = document.getElementById('body_main');
  if (!pageNav || !main) return;

  new StickyPageNav(pageNav, main);
  new ReactivePageNav(pageNav);
});
