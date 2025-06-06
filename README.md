# Ping's Nix Repo

## Packages

- `furnace-appimage` is the appimage extract of the
  [Furnace Music Tracker](https://github.com/tildearrow/furnace).

  I did this because the one from the compilation segfaulted
  (it complained something about not finding window to create,
  and nixGL didn't fix it either)

## Notes

I am new to nix, and I am using it ontop of my Debian system.
That means that I am using flakes to manage all my nix packages,
and then installing them as one big package in my `nix profile`.

What this means is although I have added a flake-compat, I would
not be able to test if it works on NixOS system or otherwise.
