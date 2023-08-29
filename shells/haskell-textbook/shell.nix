{ basePkgs ? import <nixpkgs> { } }:
let
  pinnedPkgsSource = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/74d8ebc574986457eb4b8c2d0d8f9c37b72820e4.tar.gz";
  };
  pinnedPkgs = import pinnedPkgsSource { };
in
pinnedPkgs.mkShell {
  buildInputs = [
    pinnedPkgs.haskell.compiler.ghc865
    pinnedPkgs.stack
  ];
}
