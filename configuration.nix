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
  environment.systemPackages = with pkgs; [
    gnumake
  ];
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
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
        bash = {
          enable = true;
          shellAliases.rebuild = "sudo nixos-rebuild switch";
        };
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
        urxvt.enable = true;
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
  programs.ssh.startAgent = true;
  system.stateVersion = "23.05";
  time.timeZone = "America/Vancouver";
  users.users.isaac = {
    description = "Isaac Shaha";
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    isNormalUser = true;
  };
  virtualisation.docker.enable = true;
}
