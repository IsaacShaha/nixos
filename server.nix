{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    screen
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
