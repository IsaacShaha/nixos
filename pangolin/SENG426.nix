{ lib
, pkgs
, ...
}:
{
  environment = {
    sessionVariables = {
      JAVA_HOME = "/nix/store/zmj3m7wrgqf340vqd4v90w8dw371vhjg-openjdk-17.0.7+7";
    };
    systemPackages = with pkgs; [
      azure-cli
      chromedriver
      jdk17
      maven
    ];
  };
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };
}
