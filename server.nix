{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    screen
    terraria-server
  ];
  networking = {
    firewall = {
      allowedTCPPorts = [ 7777 22 ];
      enable = true;
    };
    hostName = "isaac-server";
  };
  services.sshd.enable = true;
  services.openssh.passwordAuthentication = false;
}
