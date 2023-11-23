{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    screen
    terraria-server
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        ms-vscode-remote.remote-ssh
      ];
    })
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
