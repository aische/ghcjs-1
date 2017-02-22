
# this example is based on: https://github.com/agrafix/react-flux-example

# first, run npm install
# then, sh make.sh

stack build 

browserify src/deps.js > tmp1.js 

echo "(function(global, React, ReactDOM, ReactIntl) {" > tmp2.js
cat .stack-work/dist/x86_64-osx/Cabal-1.24.0.0_ghcjs/build/main/main.jsexe/all.js >> tmp2.js
echo "})(window, window['React'], window['ReactDOM'], window['ReactIntl']);" >> tmp2.js

uglifyjs --compress warnings=false --mangle -- tmp1.js tmp2.js > dist/out.js
cp src/index.html dist/index.html

