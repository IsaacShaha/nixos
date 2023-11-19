{ config, lib, pkgs, ... }:
let
  device = import ./device.nix;
  dockerOverlay = self: super: {
    docker = unstable.docker;
  };
  i3-modifier = "Mod4";
  unstable = import <nixos-unstable> { };
in
{
  # Stable
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
    <nixos-hardware/system76>
    device.source
  ];
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };
  home-manager = {
    useGlobalPkgs = true;
    users.isaac = { pkgs, ... }: {
      home.stateVersion = "23.05";
      programs = {
        gh.enable = true;
        git = {
          enable = true;
          extraConfig = {
            init.defaultBranch = "main";
            push.autoSetupRemote = true;
          };
          userEmail = "isaac.shaha64@gmail.com";
          userName = "Isaac Shaha";
        };
      };
    };
  };
  i18n.defaultLocale = "en_CA.UTF-8";
  networking.networkmanager.enable = true;
  nix = {
    extraOptions = ''
      experimental-features = nix-command
    '';
    # nixos/nixpkgs garbage collection.
    gc = {
      automatic = true;
      dates = "monthly";
      options = "-d";
    };
  };
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ dockerOverlay ];
  };
  system.stateVersion = "23.05";
  time.timeZone = "America/Vancouver";
  users.users.isaac = {
    description = "Isaac Shaha";
    extraGroups = [ "docker" "networkmanager" ];
    isNormalUser = true;
  };
  virtualisation.docker.enable = true;
}
