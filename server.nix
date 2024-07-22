{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    screen
    steamPackages.steamcmd
    steam-run
  ];
  networking = {
    firewall = {
      allowedTCPPorts = [ 22 ];
      enable = true;
    };
    hostName = "isaac-server";
  };
  services.openssh.settings.PasswordAuthentication = false;
  services.sshd.enable = true;
  services.xserver.enable = true;
}
