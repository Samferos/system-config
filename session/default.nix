{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./users.nix
    ./services
    ./programs.nix
    ./graphics.nix
    ./modules/desktop.nix
  ];

  ## Fonts
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerd-fonts._0xproto
      rubik
      (google-fonts.override {
        fonts = [
          "Outfit"
          "Roboto"
          "Roboto Flex"
          "Fraunces"
          "Inter"
          "IBM Plex Sans"
          "Crimson Pro"
        ];
      })
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = [
          "Rubik"
          "IBM Plex Sans"
          "Roboto"
          "Noto Sans"
          "Outfit"
        ];
        serif = [
          "Fraunces"
          "Crimson Pro"
          "Noto Serif"
        ];
        monospace = [ "0xProto Nerd Font" ];
      };
    };
    fontDir.enable = true;
  };

  ## Input
  # something something touchpad idk anymore
  services.libinput.enable = true;

  # no X11 on my watch
  services.xserver.enable = lib.mkForce false;

  # Configure keymap because it seems
  # some packages depends
  # on this X11 setting.
  services.xserver.xkb.layout = "fr";

  security.polkit.enable = true;

  session.desktop.name = "sway";

  ## XDG Settings
  xdg.portal = {
    enable = true;
    wlr = {
      enable = true;
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config = {
      common = {
        default = [
          "gnome"
          "gtk"
          "wlr"
        ];
      };
    };
  };
}
