# GHCJS simple starter projects

## ghcjsdom: GHCJS 0.2.1, GHC 8.0.1, lts-7.1, ghcjs-dom-0.5.0.2

$> stack build
ghcjs-dom-jsffi-0.5.0.2: configure
ghcjs-dom-jsffi-0.5.0.2: build
ghcjs-dom-jsffi-0.5.0.2: copy/register
ghcjs-dom-0.5.0.2: configure
ghcjs-dom-0.5.0.2: build
ghcjs-dom-0.5.0.2: copy/register
ghcjsdom-0.1.0.0: configure
Configuring ghcjsdom-0.1.0.0...
ghcjsdom-0.1.0.0: build
Preprocessing executable 'main' for ghcjsdom-0.1.0.0...
[1 of 1] Compiling Main             ( Main.hs, .stack-work/dist/x86_64-osx/Cabal-1.24.0.0_ghcjs/build/main/main-tmp/Main.js_o )
Linking .stack-work/dist/x86_64-osx/Cabal-1.24.0.0_ghcjs/build/main/main.jsexe (Main)
ghcjsdom-0.1.0.0: copy/register
Installing executable(s) in
/Users/daniel/code/myrepos/ghcjs-1/ghcjsdom/.stack-work/install/x86_64-osx/lts-7.1/ghcjs-0.2.1.9007001_ghc-8.0.1/bin
Warning: the following files would be used as linker inputs, but linking is not being done: .stack-work/dist/x86_64-osx/Cabal-1.24.0.0_ghcjs/build/main/main
Completed 3 action(s).

## reactflux: GHCJS 0.2.1, GHC 8.0.1, lts-7.1, react-flux-1.2.3

$> sh make.sh 
react-flux-1.2.3: configure
react-flux-1.2.3: build
ghcjs-dom-jsffi-0.5.0.2: configure
ghcjs-dom-jsffi-0.5.0.2: build
react-flux-1.2.3: copy/register
ghcjs-dom-jsffi-0.5.0.2: copy/register
ghcjs-dom-0.5.0.2: configure
ghcjs-dom-0.5.0.2: build
ghcjs-dom-0.5.0.2: copy/register
reactflux-0.1.0.0: configure
Configuring reactflux-0.1.0.0...
reactflux-0.1.0.0: build
Preprocessing executable 'main' for reactflux-0.1.0.0...
[1 of 1] Compiling Main             ( Main.hs, .stack-work/dist/x86_64-osx/Cabal-1.24.0.0_ghcjs/build/main/main-tmp/Main.js_o )
Linking Template Haskell (ThRunner1)
Linking Template Haskell (ThRunner2)
Linking Template Haskell (ThRunner3)
Linking Template Haskell (ThRunner4)
[1 of 1] Compiling Main             ( Main.hs, .stack-work/dist/x86_64-osx/Cabal-1.24.0.0_ghcjs/build/main/main-tmp/Main.js_o )
Linking Template Haskell (ThRunner1)
Linking Template Haskell (ThRunner2)
Linking Template Haskell (ThRunner3)
Linking Template Haskell (ThRunner4)
Linking .stack-work/dist/x86_64-osx/Cabal-1.24.0.0_ghcjs/build/main/main.jsexe (Main)
reactflux-0.1.0.0: copy/register
Installing executable(s) in
/Users/daniel/code/myrepos/ghcjs-1/reactflux/.stack-work/install/x86_64-osx/lts-7.1/ghcjs-0.2.1.9007001_ghc-8.0.1/bin
Warning: the following files would be used as linker inputs, but linking is not being done: .stack-work/dist/x86_64-osx/Cabal-1.24.0.0_ghcjs/build/main/main
Completed 4 action(s).

## refl: GHCJS 0.2.0.20151029, GHC 7.10.2, lts-3.16, reflex-0.3.2

$ stack build
Ignoring that the GHCJS boot package "aeson" has a different version, 0.9.0.1, than the resolver's wanted version, 0.8.0.2
Ignoring that the GHCJS boot package "attoparsec" has a different version, 0.13.0.1, than the resolver's wanted version, 0.12.1.6
Ignoring that the GHCJS boot package "scientific" has a different version, 0.3.3.8, than the resolver's wanted version, 0.3.4.4
Ignoring that the GHCJS boot package "case-insensitive" has a different version, 1.2.0.4, than the resolver's wanted version, 1.2.0.5
Ignoring that the GHCJS boot package "hashable" has a different version, 1.2.3.2, than the resolver's wanted version, 1.2.3.3
Ignoring that the GHCJS boot package "async" has a different version, 2.0.1.6, than the resolver's wanted version, 2.0.2
Ignoring that the GHCJS boot package "vector" has a different version, 0.11.0.0, than the resolver's wanted version, 0.10.12.3
Ignoring that the GHCJS boot package "text" has a different version, 1.2.1.1, than the resolver's wanted version, 1.2.1.3
Ignoring that the GHCJS boot package "dlist" has a different version, 0.7.1.1, than the resolver's wanted version, 0.7.1.2
Ignoring that the GHCJS boot package "pretty" has a different version, 1.1.3.2, than the resolver's wanted version, 1.1.2.0
Ignoring that the GHCJS boot package "containers" has a different version, 0.5.6.3, than the resolver's wanted version, 0.5.6.2
Ignoring that the GHCJS boot package "transformers" has a different version, 0.4.3.0, than the resolver's wanted version, 0.4.2.0
ref-tf-0.4: configure
ref-tf-0.4: build
these-0.6.1.0: configure
ref-tf-0.4: copy/register
these-0.6.1.0: build
ghcjs-dom-0.2.3.0: configure
ghcjs-dom-0.2.3.0: build
these-0.6.1.0: copy/register
reflex-0.3.2: configure
reflex-0.3.2: build
reflex-0.3.2: copy/register
ghcjs-dom-0.2.3.0: copy/register
reflex-dom-0.2: configure
reflex-dom-0.2: build
reflex-dom-0.2: copy/register
refl-0.1.0.0: configure
Configuring refl-0.1.0.0...
refl-0.1.0.0: build
Preprocessing executable 'main' for refl-0.1.0.0...
[1 of 1] Compiling Main             ( Main.hs, .stack-work/dist/x86_64-osx/Cabal-1.22.4.0_ghcjs/build/main/main-tmp/Main.js_o )
[1 of 1] Compiling Main             ( Main.hs, .stack-work/dist/x86_64-osx/Cabal-1.22.4.0_ghcjs/build/main/main-tmp/Main.js_o )
Linking .stack-work/dist/x86_64-osx/Cabal-1.22.4.0_ghcjs/build/main/main.jsexe (Main)
refl-0.1.0.0: copy/register
Installing executable(s) in
/Users/daniel/code/myrepos/ghcjs-1/refl/.stack-work/install/x86_64-osx/lts-3.16/ghcjs-0.2.0.20151029_ghc-7.10.2/bin
Warning: the following files would be used as linker inputs, but linking is not being done: .stack-work/dist/x86_64-osx/Cabal-1.22.4.0_ghcjs/build/main/main
Completed 6 action(s).

## refl2: GHCJS 0.2.0.20160414, GHC 7.10.3, lts-6.1, reflex-0.4.0 (with warnings)

$ stack build
Ignoring that the GHCJS boot package "aeson" has a different version, 0.9.0.1, than the resolver's wanted version, 0.11.2.0
Ignoring that the GHCJS boot package "attoparsec" has a different version, 0.13.0.1, than the resolver's wanted version, 0.13.0.2
Ignoring that the GHCJS boot package "unordered-containers" has a different version, 0.2.5.1, than the resolver's wanted version, 0.2.7.0
Ignoring that the GHCJS boot package "scientific" has a different version, 0.3.3.8, than the resolver's wanted version, 0.3.4.6
Ignoring that the GHCJS boot package "case-insensitive" has a different version, 1.2.0.4, than the resolver's wanted version, 1.2.0.6
Ignoring that the GHCJS boot package "hashable" has a different version, 1.2.3.2, than the resolver's wanted version, 1.2.4.0
Ignoring that the GHCJS boot package "async" has a different version, 2.0.1.6, than the resolver's wanted version, 2.1.0
Ignoring that the GHCJS boot package "text" has a different version, 1.2.1.1, than the resolver's wanted version, 1.2.2.1
Ignoring that the GHCJS boot package "syb" has a different version, 0.5.1, than the resolver's wanted version, 0.6
Ignoring that the GHCJS boot package "stm" has a different version, 2.4.4, than the resolver's wanted version, 2.4.4.1
Ignoring that the GHCJS boot package "parallel" has a different version, 3.2.0.6, than the resolver's wanted version, 3.2.1.0
Ignoring that the GHCJS boot package "dlist" has a different version, 0.7.1.1, than the resolver's wanted version, 0.7.1.2
Ignoring that the GHCJS boot package "pretty" has a different version, 1.1.3.2, than the resolver's wanted version, 1.1.2.0
Ignoring that the GHCJS boot package "containers" has a different version, 0.5.6.3, than the resolver's wanted version, 0.5.6.2
Ignoring that the GHCJS boot package "transformers" has a different version, 0.4.3.0, than the resolver's wanted version, 0.4.2.0
ref-tf-0.4.0.1: configure
ref-tf-0.4.0.1: build
ref-tf-0.4.0.1: copy/register
reflex-0.4.0: configure
reflex-0.4.0: build
reflex-0.4.0: copy/register
reflex-dom-0.3: configure
reflex-dom-0.3: build
reflex-dom-0.3: copy/register
refl2-0.1.0.0: configure
Configuring refl2-0.1.0.0...
refl2-0.1.0.0: build
Preprocessing executable 'main' for refl2-0.1.0.0...
[1 of 1] Compiling Main             ( Main.hs, .stack-work/dist/x86_64-osx/Cabal-1.22.4.0_ghcjs/build/main/main-tmp/Main.js_o )
[1 of 1] Compiling Main             ( Main.hs, .stack-work/dist/x86_64-osx/Cabal-1.22.4.0_ghcjs/build/main/main-tmp/Main.js_o )
Linking .stack-work/dist/x86_64-osx/Cabal-1.22.4.0_ghcjs/build/main/main.jsexe (Main)
refl2-0.1.0.0: copy/register
Installing executable(s) in
/Users/daniel/code/myrepos/ghcjs-1/refl2/.stack-work/install/x86_64-osx/lts-6.1/ghcjs-0.2.0_ghc-7.10.3/bin
Warning: the following files would be used as linker inputs, but linking is not being done: .stack-work/dist/x86_64-osx/Cabal-1.22.4.0_ghcjs/build/main/main
Completed 4 action(s).

