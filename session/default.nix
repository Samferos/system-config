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
      noto-fonts-emoji
      nerd-fonts._0xproto
      (google-fonts.override {
        fonts = [
          "Outfit"
          "Roboto"
          "Roboto Flex"
          "Fraunces"
          "Rubik"
          "Inter"
          "IBM Plex Sans"
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

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-mozc-ut
    ];
    fcitx5.waylandFrontend = true;
  };

  session.desktop.name = "sway";

  ## XDG Settings
  xdg.portal = {
    enable = true;
    wlr = {
      enable = true;
      settings = {
        screencast = {
          max_fps = 60;
          chooser_type = "dmenu";
          chooser_cmd = "${pkgs.wofi}/bin/wofi --show dmenu";
        };
      };
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

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [
        "alacritty.desktop"
        # FIXME this is kinda bad and not self contained.
        # Should maybe make a terminal-emulator module.
      ];
    };
  };
}
