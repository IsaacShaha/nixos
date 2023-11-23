{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    screen
    terraria-server
  ];
  networking = {
    firewall = {
      allowedTCPPorts = [ 7777 ];
      enable = true;
    };
    hostName = "isaac-server";
  };
  vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      ms-vscode-remote.remote-ssh
    ];
  };
  services.sshd.enable = true;
}
