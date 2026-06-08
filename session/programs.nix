{ pkgs, pkgs-unstable, ... }:
{
  programs.localsend.enable = true;
  programs.firefox.enable = false;
  programs.git.enable = true;
  programs.thunderbird.enable = true;
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamescope.enable = true;
  programs.gamemode = {
    enable = true;
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.dconf.enable = true;

  hardware.brillo.enable = true; # backlight control tool

  hardware.keyboard.qmk.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    micro
    wget
    tree
    jq # JSON Utility CLI Tool
    brillo
    rar
    unrar
    crosspipe # GTK-UI for pipewire
    xdg-user-dirs
    pwvucontrol
    npins
    gimp3
    libreoffice-fresh
    ungoogled-chromium
    celluloid
    gapless
    playerctl
  ];
}
