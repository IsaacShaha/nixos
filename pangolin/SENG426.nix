{ lib
, pkgs
, ...
}:
{
  environment.systemPackages = with pkgs; [
    azure-cli
    chromedriver
    maven
  ];
}
