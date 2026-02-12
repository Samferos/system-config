{ pkgs, pkgs-unstable, ... }:
{
  programs.firefox.enable = false;
  programs.git.enable = true;
  programs.thunderbird.enable = true;
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamescope.enable = true;
  programs.gamemode = {
    enable = true;
  };

  services.emacs = {
    enable = true;
    package = with pkgs; ((emacsPackagesFor emacs).emacsWithPackages (epkgs: with epkgs; [
      tree-sitter-langs
      treesit-grammars.with-all-grammars
    ]));
    defaultEditor = true;
    startWithGraphical = true;
  };

  programs.dconf.enable = true;

  hardware.brillo.enable = true; # backlight control tool

  hardware.keyboard.qmk.enable = true;

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
    npins
    gimp3
    libreoffice-fresh
    ungoogled-chromium
    celluloid
    gapless
  ];
}
