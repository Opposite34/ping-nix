{ pkgs, ... }: let
  pname = "Furnace";
  pnameLower = pkgs.lib.toLower pname;
  version = "0.6.8.2";

  src = pkgs.fetchurl {
    url = "https://github.com/tildearrow/furnace/releases/download/v${version}/${pname}-${version}-x86_64.AppImage";
    hash = "sha256-kkEjCAomTufBRk+V8tvnVySDYvtbNMQXr5R6yHEQDgw=";
  };
  appimageContents = pkgs.appimageTools.extract {inherit pname version src;};
in
pkgs.appimageTools.wrapType2 {
  inherit pname version src;
  pkgs = pkgs;
  extraInstallCommands = ''
    install -m 444 -D \
    ${appimageContents}/${pnameLower}.desktop -t $out/share/applications
    cp -r ${appimageContents}/usr/share/icons $out/share
  '';
}
