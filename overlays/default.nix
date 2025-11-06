{
  nixpkgs.overlays = [
    (import ./nautilus.nix)
    (import ./xdg-desktop-portal-wlr.nix)
  ];
}
