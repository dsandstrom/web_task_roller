import {Form} from './../src/forms';

window.addEventListener("load", (event) => {
  const element = document.getElementById('contact-form');
  if (!element) return;

  new Form(element);
});
