{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    terraria-server
  ];
  networking = {
    allowedTCPPorts = [ 7777 ];
    hostName = "isaac-server";
  };
  services.sshd.enable = true;
}
