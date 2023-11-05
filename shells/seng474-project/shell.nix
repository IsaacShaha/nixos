{ pkgs ? import <nixpkgs> { } }:
with pkgs;
let
  gym-super-mario-bros = with python3.pkgs; buildPythonPackage {
    buildInputs = [ nes-py ];
    pname = "gym-super-mario-bros";
    version = "7.3.2";
    src = fetchFromGitHub {
      owner = "Kautenja";
      repo = "gym-super-mario-bros";
      rev = "bcb8f10c3e3676118a7364a68f5c0eb287116d7a";
      sha256 = "sha256-bTm6KgfPFSVZ/C4Aa2ClMjqg2tXuf3xv29Q9voeAxUM=";
    };
  };
  nes-py = with python3.pkgs; buildPythonPackage {
    pname = "nes-py";
    version = "8.2.1";
    src = fetchFromGitHub {
      owner = "Kautenja";
      repo = "nes-py";
      rev = "b6f4e26a96cf1dc2329b3b45b9f785dd7dbb30c6";
      sha256 = "sha256-bTm6KgfPFSVZ/C4Aa2ClMjqg2tXuf3xv29Q9voeAxUM=";
    };
  };
in
pkgs.mkShell {
  buildInputs =
    [
      (python38.withPackages
        (ps: with ps; [
          gym-super-mario-bros
        ]))
    ];
}
