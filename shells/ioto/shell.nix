let
  homeDirectory = builtins.getEnv "HOME";
  reposDirectory = homeDirectory + "/repos";
  nixpkgsDirectory = reposDirectory + "/nixpkgs";
  nixosDirectory = reposDirectory + "/nixos";
  iotoDirectory = nixosDirectory + "/shells/ioto";
  secrets = import "${nixosDirectory}/secrets.nix";
  pkgs = import nixpkgsDirectory { };
  awscli2-wrapped = with pkgs; stdenv.mkDerivation {
    inherit (awscli2) pname version meta;
    nativeBuildInputs = [ makeWrapper ];
    buildCommand = ''
      makeWrapper ${awscli2}/bin/aws $out/bin/aws \
        --set PYTHONHOME "${python3}"
    '';
  };
  python = pkgs.python311.withPackages (ps: with ps; [
    boto3
    pandas
    pygithub
    pyyaml
    requests
  ]);
in
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    awscli2-wrapped
    awscurl
    projectlibre
    python
  ];
  IOTO_WORKFLOW_APP_PRIVATE_KEY = secrets.IOTO_WORKFLOW_APP_PRIVATE_KEY;
}
