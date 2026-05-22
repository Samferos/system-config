{
  config,
  pkgs,
  pkgs-unstable,
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
      _0xproto
      rubik
      font-awesome
      (google-fonts.override {
        fonts = [
          "Outfit"
          "Google Sans"
          "Roboto"
          "Roboto Flex"
          "Fraunces"
          "Inter"
          "IBM Plex Sans"
          "Source Serif 4"
          "Crimson Pro"
        ];
      })
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = [
          "Rubik"
          "Google Sans"
          "IBM Plex Sans"
          "Roboto"
          "Noto Sans"
          "Outfit"
        ];
        serif = [
          "Fraunces"
          "Source Serif 4"
          "Crimson Pro"
          "Noto Serif"
        ];
        monospace = [ "0xProto" ];
        emoji = [
          "Noto Emoji Color"
          "Font Awesome 7 Free"
        ];
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

  session.desktop.name = "niri";
  session.desktop.terminalEmulator = pkgs.foot;

  specialisation.gnome.configuration = {
    session.desktop.name = lib.mkForce "gnome";
  };

  ## XDG Settings
  xdg.portal = {
    enable = true;
    wlr.enable = lib.mkForce false;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
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

  ## Default Editor
  environment.variables.EDITOR = "micro";
}
