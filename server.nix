{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    screen
    terraria-server
  ];
  networking = {
    firewall = {
      allowedTCPPorts = [ 7777 8083 ];
      enable = true;
    };
    hostName = "isaac-server";
  };
  services.sshd.enable = true;
}
