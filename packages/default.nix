let
  pkgs = import (import ../npins).nixpkgs {};
  inherit (pkgs) callPackage;
in
{
  kotlin-lsp = callPackage ./kotlin-lsp.nix {};
  livebg = callPackage ./livebg.nix {};
  wl_shimeji = callPackage ./wl_shimeji.nix {};
}
