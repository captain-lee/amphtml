#!/bin/sh
./node_modules/.bin/browserify \
-t [ babelify --presets env ] \
-g [ envify purge --NODE_ENV production ] \
-g uglifyify \
-r prop-types -r preact:react -r preact-compat:react-dom \
-r moment/min/moment-with-locales:moment \
-r react-dates -r react-dates/initialize -r react-dates/constants \
./third_party/react-dates/index.js | \
node ./build-system/scope-require.js | \
./node_modules/.bin/derequire > ./third_party/react-dates/bundle.js
# TODO(#18268, erwinm): This is to temporary get around a closure bug where it does not see modules
# that have no exports for single pass compilation.
echo "\nexports.erwinmHack=1;" >> ./third_party/react-dates/bundle.js
cp ./node_modules/react-dates/lib/css/_datepicker.css ./third_party/react-dates/
