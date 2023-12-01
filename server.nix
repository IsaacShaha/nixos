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
}
