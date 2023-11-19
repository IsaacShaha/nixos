{ pkgs, ... }:
{
  networking.hostName = "isaac-server";
  services.sshd.enable = true;
}
