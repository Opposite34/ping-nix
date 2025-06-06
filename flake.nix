{
  description = "Ping's Nix Packages Repo";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-compat.url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";
  };
  outputs = { self, nixpkgs, flake-compat }: {
    packages.x86_64-linux =
      let
        pkgs = import "${nixpkgs}" {
          system = "x86_64-linux";
        };
        callPackage = pkgs.callPackage;
      in {
        furnace-appimage = callPackage ./pkgs/furnace-appimage.nix { pkg = nixpkgs; };
      };
  };
}
