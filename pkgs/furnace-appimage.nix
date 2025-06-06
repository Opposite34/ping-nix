{ pkgs, ... }: let
  pname = "Furnace";
  version = "0.6.8.2";

  src = pkgs.fetchurl {
    url = "https://github.com/tildearrow/furnace/releases/download/v${version}/${pname}-${version}-x86_64.AppImage";
    hash = "sha256-924123080a264ee7c1464f95f2dbe757248362fb5b34c417af947ac871100e0c";
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
