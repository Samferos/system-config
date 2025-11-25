{ pkgs, pkgs-unstable, ... }:
{
  programs.neovim = {
    enable = true;
    package = pkgs-unstable.neovim-unwrapped;
    defaultEditor = true;
  };

  programs.firefox.enable = false;
  programs.git.enable = true;
  programs.thunderbird.enable = true;
  programs.steam.enable = true;
  programs.gamescope.enable = true;
  programs.gamemode = {
    enable = true;
  };

  programs.dconf.enable = true;

  hardware.brillo.enable = true; # backlight control tool

  programs.adb.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    tree
    jq # JSON Utility CLI Tool
    brillo
    rar
    unrar
    helvum # GTK-UI for pipewire
    xdg-user-dirs
    pwvucontrol
    mpv
    npins
    gimp3
    libreoffice-fresh
    pkgs-unstable.ungoogled-chromium
  ];
}
