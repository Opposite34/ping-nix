{ pkgs, ... }: let
  pname = "furnace";
  version = "0.6.8.3";

  src = pkgs.fetchurl {
    url = "https://github.com/tildearrow/furnace/releases/download/v${version}/Furnace-${version}-x86_64.AppImage";
    hash = "sha256-rLBcIaakG/jKTtEOsTwEmwuronNSzRXE5/b72RHCtp4=";
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
  '';

  meta = {
    description = "a multi-system chiptune tracker compatible with DefleMask modules";
    homepage = "https://github.com/tildearrow/furnace";
    changelog = "https://github.com/tildearrow/furnace/releases/tag/v${version}";
    license = pkgs.lib.licenses.gpl2Plus;
    maintainers = with pkgs.lib.maintainers; [ opposite34 ];
    platforms = [ "x86_64-linux" ];
  };
}
