{ pkgs, ... }:

let
  sources = import ../npins;
  nixpkgs-unstable = import sources.nixpkgs-unstable { };
in
{
  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      sway = {
        prettyName = "sway";
        comment = "an i3 compatible wayland compositor";
        binPath = "/run/current-system/sw/bin/sway";
      };
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.firefox.enable = false;
  programs.chromium = {
    enable = true;
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
    ];
  };
  programs.git.enable = true;
  programs.thunderbird.enable = true;
  programs.steam.enable = true;
  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  programs.dconf.enable = true;

  hardware.brillo.enable = true; # backlight control tool

  programs.adb.enable = true;

  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    tree
    jq # JSON Utility CLI Tool
    brillo
    alacritty
    rar
    unrar
    helvum
    xdg-user-dirs
    pwvucontrol
    python3
    mpv
    nixpkgs-unstable.euphonica
    npins
    glib
    gamemode
    gimp3
    libreoffice-fresh
    ungoogled-chromium
  ];
}
