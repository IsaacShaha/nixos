let
  homeDirectory = builtins.getEnv "HOME";
  reposDirectory = homeDirectory + "/repos";
  nixpkgsDirectory = reposDirectory + "/nixpkgs";
  nixosDirectory = reposDirectory + "/nixos";
  iotoDirectory = nixosDirectory + "/shells/ioto";
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
    pygithub
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
}
