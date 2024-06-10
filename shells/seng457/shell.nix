{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  pkgs = pkgs.python311.withPackages (ps: with ps; [
    qiskit
  ]);
}
