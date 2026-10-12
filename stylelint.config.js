// https://github.com/cahamilton/stylelint-config-property-sort-order-smacss

module.exports = {
  extends: [
    'stylelint-config-sass-guidelines',
    'stylelint-config-property-sort-order-smacss'
  ],
  plugins: ['stylelint-order'],
  rules: {
    'order/properties-alphabetical-order': null,
    'max-nesting-depth': 4,
    'selector-no-qualifying-type': [true, { ignore: ['class'] }]
  }
};
