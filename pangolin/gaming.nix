{ lib
, pkgs
, ...
}:
let
  space-station-14-nixpkgs-commit = pkgs.fetchFromGitHub {
    hash = "sha256-WDCOwsT/Doto2fCNIjfORBNEsFmFkCiCENcu3KlB6bk=";
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "f01c891a3fb8b91fa2573676b276352c613e096d";
  };
  space-station-14-nixpkgs = import space-station-14-nixpkgs-commit { };
in
{
  environment.systemPackages = with pkgs; [
    r2modman
    space-station-14-nixpkgs.space-station-14-launcher
  ];
  programs = {
    gamemode.enable = true;
    steam.enable = true;
  };
}
