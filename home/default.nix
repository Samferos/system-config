# SPDX-FileCopyrightText: 2023 Jade Lovelace
#
# SPDX-License-Identifier: CC0-1.0

let
  sources = import ../../npins;

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

      ## Utility
      fd # nvim-telescope find file
      ripgrep
      tree-sitter
      texliveFull
      swayimg
      swww
      wayshot
      btop
      wljoywake
      matugen
      bitwarden
      (pkgs-unstable.blender.override {
        cudaSupport = true;
      })
      (pkgs.wrapOBS {
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-pipewire-audio-capture
        ];
      })

      ## Developement
      android-studio
      godot-mono
      nixd
      nixfmt-rfc-style
      git-repo

      ## Emulators
      cemu
      ryubing

      ## Theming
      tela-icon-theme
      adw-gtk3
      capitaine-cursors

      ## Shell
      antidote
    ];
  };
}
