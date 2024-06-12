{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    screen
    steamPackages.steamcmd
    wineWowPackages.stable
    xvfb-run
  ];
  networking = {
    firewall = {
      allowedTCPPorts = [ 22 ];
      enable = true;
    };
    hostName = "isaac-server";
  };
  services.sshd.enable = true;
  services.openssh.settings.PasswordAuthentication = false;
}
