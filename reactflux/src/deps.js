window['React'] = require('react');
window['ReactDOM'] = require('react-dom');
var ri = require('react-intl');
window['ReactIntl'] = ri;

ri.addLocaleData([
    require('react-intl/locale-data/en').en,
    require('react-intl/locale-data/de').de,
    require('react-intl/locale-data/fr').fr
]);

window['config'] = {
    locale: 'en'
};

if (!window['Intl']) {
    require('intl');
    require('intl/locale-data/jsonp/en.js');
    require('intl/locale-data/jsonp/de.js');
    require('intl/locale-data/jsonp/fr.js');
}
