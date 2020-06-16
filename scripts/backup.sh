#!/bin/sh
set -euf

[ -d backup-list ] && rm -rf backup-list
mkdir backup-list
cd backup-list

printf 'Brew\n'
[ "$(uname -s)" = 'Darwin' ] && brew bundle dump # >Brewfile
([ "$(uname -s)" = 'Linux' ] || [ "$(uname -s)" = 'Windows' ]) && command -v apt >/dev/null 2>&1 && apt list --installed >apt.txt
([ "$(uname -s)" = 'Linux' ]) && command -v dnf >/dev/null 2>&1 && dnf list installed >dnf.txt

printf 'Python\n'
pip list --format=freeze --quiet >requirements-pip.txt
pip2 list --format=freeze --quiet >requirements-pip2.txt
pip3 list --format=freeze --quiet >requirements-pip3.txt

printf 'JS\n'
npm list -g --depth 0 >npm.txt || true

printf 'Ruby\n'
gem list --quiet >Gemfile

printf 'Rust\n'
cargo install --list >cargo.txt
printf '\n\n' >>cargo.txt
cargo --list >>cargo.txt

printf 'Haskell\n'
cabal list --installed >cabal.txt
ghc-pkg list >ghc-pkg.txt

printf 'Swift\n'
mint list >Mintfile