let
  sources = import ../npins;
  xdg-desktop-portal-wlr-source = sources.xdg-desktop-portal-wlr;
in
final: prev: {
  xdg-desktop-portal-wlr = prev.xdg-desktop-portal-wlr.overrideAttrs (nprev: {
    src = xdg-desktop-portal-wlr-source;
  });
}
