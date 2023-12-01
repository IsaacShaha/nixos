{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    screen
    terraria-server
  ];
  networking = {
    firewall = {
      allowedTCPPorts = [ 7777 ];
      enable = true;
    };
    hostName = "isaac-server";
  };
  services = {
    sshd.enable = true;
    xrdp = {
      enable = true;
      defaultWindowManager = "i3";
      openFirewall = true;
    };
    xserver = {
      displayManager.defaultSession = "none+i3";
      enable = true;
      windowManager.i3.enable = true;
    };
  };
}
