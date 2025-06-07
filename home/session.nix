{ pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";
  };

  home.pointerCursor = {
    enable = true;
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 32;
    gtk.enable = true;
  };

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.tela-icon-theme;
      name = "Tela-blue";
    };
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };
    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
      bookmarks = [
        "file:///home/samuel/Documents/"
        "file:///home/samuel/Downloads/"
        "file:///home/samuel/Music/"
        "file:///home/samuel/Pictures/"
        "file:///home/samuel/Music/Collection"
      ];
      extraCss = ''
        @import "./colors.css";
      '';
    };
    gtk4.extraCss = ''
      @import "./colors.css";
    '';
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
}
