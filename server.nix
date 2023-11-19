{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    terraria-server
  ];
  networking.hostName = "isaac-server";
  services.sshd.enable = true;
}
