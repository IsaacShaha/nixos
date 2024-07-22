{ lib
, pkgs
, ...
}:
{
  environment.systemPackages = with pkgs; [
    gcc
    imagemagick
    python3
  ];
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
}
