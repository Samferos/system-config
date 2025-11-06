# SPDX-FileCopyrightText: 2023 Jade Lovelace
#
# SPDX-License-Identifier: CC0-1.0

let
  sources = import ../npins;

  pkgs = import sources.nixpkgs (import ./nixpkgs.nix { lib = pkgs.lib; });

  pkgs-unstable = import sources.nixpkgs-unstable (import ./nixpkgs.nix { lib = pkgs-unstable.lib; });

  flakey-profile = import (sources.flakey-profile + "/lib");
in
{
  profile = flakey-profile.mkProfile {
    # Usage:
    # Switch to this profile:
    #   nix run -f . profile.switch
    # Revert a profile change:
    #   nix run -f . profile.rollback
    # Build, without switching:
    #   nix build -f . profile
    inherit pkgs;
    name = "samuel";
    pinned = { inherit (sources) nixpkgs; };
    paths = with pkgs; [
      ## Socials
      discord

      ## Design
      inkscape
      aseprite

      ## Games
      gale
      pkgs-unstable.heroic
      prismlauncher

      ## Music
      ardour
      guitarix
      beets
      ffmpeg # Beets replaygain method
      audacity
      mprisence # Discord MPRIS RPC
      pkgs-unstable.recordbox

      ## Utility
      fd # nvim-telescope find file
      ripgrep
      tree-sitter
      texliveFull
      swayimg
      swww
      wayshot
      btop
      matugen
      bitwarden
      blender
      (pkgs.wrapOBS {
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-pipewire-audio-capture
        ];
      })
      appimage-run

      ## Developement
      (pkgs-unstable.android-studio.override {
        tiling_wm = true;
        forceWayland = true;
      })
      (pkgs-unstable.jetbrains.idea-community.override {
        vmopts = ''
        -Dawt.toolkit.name=WLToolkit
        '';
      })
      # (pkgs-unstable.vscode-with-extensions.override {
      #   vscode = pkgs-unstable.vscodium;
      #   vscodeExtensions = with pkgs-unstable.vscode-extensions; [
      #     vscodevim.vim
      #   ];
      # })
      pkgs-unstable.vscodium-fhs
      godot-mono
      nixd
      nil
      nixfmt-rfc-style
      git-repo

      ## Emulators
      cemu
      pkgs-unstable.ryubing

      ## Theming
      tela-icon-theme
      adw-gtk3
      capitaine-cursors

      ## Shell
      antidote
    ];
  };
}
