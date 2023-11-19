{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    terraria-server
  ];
  networking = {
    firewall = {
      allowedTCPPorts = [ 7777 ];
      enable = true;
    };
    hostName = "isaac-server";
  };
  services.sshd.enable = true;
}
