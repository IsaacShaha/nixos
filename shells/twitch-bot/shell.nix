let
  pkgs = import <nixpkgs> { };
in
pkgs.mkShell {
  packages = with pkgs; [
    python311
    (poetry.override { python3 = python311; })
  ];
}
