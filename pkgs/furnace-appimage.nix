{ pkgs, ... }: let
  pname = "Furnace";
  version = "0.6.8.2";

  src = pkgs.fetchurl {
    url = "https://github.com/tildearrow/furnace/releases/download/v${version}/${pname}-${version}-x86_64.AppImage";
    hash = "sha256-DJcgJMekoxVesl9kKjfLPix2Nbr42i7cpEHJiTnBUwU%3D»/nix/store/0sg4h9ihh33mpg0lsc8idsir4zb9p2xj";
  };
  appimageContents = pkgs.appimageTools.extract {inherit pname version src;};
in
pkgs.appimageTools.wrapType2 {
  inherit pname version src;
  pkgs = pkgs;
  extraInstallCommands = ''
    install -m 444 -D \
    ${appimageContents}/${pname}.desktop -t $out/share/applications
    cp -r ${appimageContents}/usr/share/icons $out/share
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=${pname}'
  '';
}
