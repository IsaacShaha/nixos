{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    screen
    steamPackages.steamcmd
    steam-run
  ];
  networking = {
    firewall = {
      allowedTCPPorts = [ 22 7777 7778 ];
      allowedUDPPorts = [ 7777 7778 34197 ];
      enable = true;
    };
    hostName = "isaac-server";
  };
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };
  services.xserver.enable = true;
}
