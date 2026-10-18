// https://github.com/rickharrison/validate.js
import FormValidator from './validate.js';

export class Form {
  constructor(elem) {
    this.form = elem;
    this.button = this.form.querySelector("[type='submit']");

    this.keyupValidate = false;

    this.afterValidate = this.afterValidate.bind(this);
    this.validator = this.initValidator();
    if (!this.validator) return;

    this.fields = this.validator.fields;
    this.watchInputs();
  }

  initValidator() {
    const options = this.options()
    if (!options) return;

    const validator = new FormValidator(this.form.name, options, this.afterValidate);

    validator.setMessage('required', 'required');
    return validator;
  }

  inputField(input) {
    var field = input.parentNode;
    if (field.classList.contains('field')) {
      return field;
    }
    return field.parentNode;
  }

  displayError(error) {
    const input = document.getElementById(error.id);
    if (!input) return;

    const field = this.inputField(input);
    this.addClass(input, field);
    this.updateMessage(input, field, error.message);
  }

  // used by displayError
  addClass(input, field) {
    input.classList.add('error');
    field.classList.add('error');
  }

  // used by displayError
  updateMessage(input, field, message) {
    const messageClass = 'field-message';
    let elem = field.querySelector(`.${messageClass}`);

    if (!elem) {
      elem = this.addNewMessage(input, messageClass);
    }
    elem.innerHTML = message;
    elem.classList.remove('hide');
  }

  // used by displayError
  addNewMessage(input, messageClass) {
    const elem = document.createElement('p');

    elem.classList.add(messageClass);
    this.inputField(input).appendChild(elem);;
    return elem;
  }

  options() {
    const matches = this.form.name.match(/^(\w+)_form$/);
    if (!matches) return;

    var currentName = matches[1];
    if (!currentName) return;

    return [
      {
        name: `${currentName}[name]`,
        display: 'Name',
        rules: 'required'
      },
      {
        name: `${currentName}[return_email]`,
        display: 'Email',
        rules: 'required|valid_email'
      },
      {
        name: `${currentName}[body]`,
        display: 'Message',
        rules: 'required'
      }
    ];
  }

  validateField(input, value) {
    if (!input) return;

    const field = this.fields[input.name]
    if (!field) return;

    field.element = input;
    field.value = value;
    field.id = input.id;

    // clear error for field
    this.validator.errors = this.validator.errors.filter(function (obj) {
      return obj.name !== field.name;
    });
    this.validator._validateField(field);

    const newErrors = this.validator.errors.filter(function (obj) {
      return obj.name === field.name;
    });
    if (newErrors.length === 0) {
      for (let message of field.element.parentNode.querySelectorAll('.field-message')) {
        message.classList.add('hide');
      }
    }
  }

  watchInputs() {
    const form = this;
    const values = Object.values(form.fields)

    values.forEach((field) => {
      let selector = 'input[name="' + field.name + '"]';
      let inputNode = this.form.querySelector(selector);

      if (!inputNode) {
        selector = 'textarea[name="' + field.name + '"]';
        inputNode = this.form.querySelector(selector);
      }

      if (!inputNode) return;

      inputNode.addEventListener('keyup', (event) => {
        if (form.keyupValidate) {
          form.validateField(event.target, event.target.value);
          form.afterValidate(form.validator.errors, event);
        }
      })
    });
  }

  clearErrors() {
    this.button.disabled = false;
    for (let error of this.form.querySelectorAll('.error')) {
      error.classList.remove('error');
    }
  }

  afterValidate(errors, event) {
    this.clearErrors();
    if (!errors.length) return true;

    this.keyupValidate = true;

    for (let error of errors) {
      this.displayError(error);
    }
    if (event.type == 'submit') {
      event.stopImmediatePropagation();
    }
    return false;
  }
};
