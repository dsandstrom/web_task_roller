import {StickyPageNav} from './../src/sticky_page_nav';

window.addEventListener("load", (event) => {
  const pageNav = document.getElementById('page_nav');
  if (!pageNav) return;

  new StickyPageNav(pageNav);
});
