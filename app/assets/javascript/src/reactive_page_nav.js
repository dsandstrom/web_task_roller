// FIXME: not quite working when scrolling from bottom

export class ReactivePageNav {
  constructor(nav) {
    this.elem = nav;
    this.links = this.elem.getElementsByTagName('a');
    if (!this.links) return;

    this.sections = this.buildSections();
    if (!this.sections) return;

    this.map = this.buildMap();
    if (!this.map.size) return;

    this.setupIntersections();
  }

  buildMap() {
    const map = new Map();

    for(const link of this.links) {
      const matches = link.href.match(/#(.+)/);
      const id = matches[1]
      if (!id) continue;

      const section = document.getElementById(id);
      if (!section) continue;

      map.set(id, new Map([['link', link], ['section', section]]));
    }

    return map;
  }

  buildSections() {
    const sections = []

    for(const link of this.links) {
      const matches = link.href.match(/#(.+)/);
      const id = matches[1]
      if (!id) continue;

      const section = document.getElementById(id);
      if (!section) continue;

      sections.push(section);
    }

    return sections;
  }

  setupIntersections() {
    const map = this.map;
    let sections = [];
    const links = [];

    map.forEach((entry) => {
      links.push(entry.get('link'));
      sections.push(entry.get('section'));
    });

    const observer = new IntersectionObserver(
      (entries) => {
        for (const entry of entries) {
          const currentItem = map.get(entry.target.id);

          if(entry.isIntersecting) {
            for (const link of links) {
              link.classList.remove('current-page');
            }
            currentItem.get('link').classList.add('current-page');
          } else {
          }
        }
      }, {
        threshold: 0.6
      }
    );

    for(const section of sections) {
      observer.observe(section);
    }
  }
};
