final: prev:
let
  pkgs = import ../packages { inherit (prev) callPackage; };
in
{
  kotlin-lsp = pkgs.kotlin-lsp;
}
