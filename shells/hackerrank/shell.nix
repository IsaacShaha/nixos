# A Haskell environment replacing that found @ https://www.hackerrank.com/environment?utm_medium=social&utm_source=blog.
{ pkgs ? import <nixpkgs> { } }:
let
  source = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/1f212565d2fcfe2c880e739d4462731a6ec19654.tar.gz";
  };
  ghcPkgs = import source { };
  hackerrankHaskell = ghcPkgs.haskell.packages.ghc863.ghcWithPackages (p: with p; [
    base-prelude
    logict
    pipes
    hashtables
    random
    text
    vector
    aeson
    lens
    lens-aeson
    split
    bytestring
    array
    # arrow-list # this is broken... I doubt this is worth fixing at the moment.
    regex-applicative
    regex-base
    regex-compat
    regex-pcre-builtin
    regex-posix
    regex-tdfa
    parsec
    unordered-containers
    attoparsec
    comonad
    deepseq
    dlist
    either
    matrix
    MemoTrie
    threads
    monad-memo
    memoize
    base-unicode-symbols
    basic-prelude
    bifunctors
  ]);
in
ghcPkgs.mkShell {
  buildInputs = [ hackerrankHaskell ];
}
