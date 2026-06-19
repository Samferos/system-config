let
  sources = import ../npins;

  pkgs = import sources.nixpkgs (import ./nixpkgs.nix { lib = pkgs.lib; });

  pkgs-unstable = import sources.nixpkgs-unstable (import ./nixpkgs.nix { lib = pkgs-unstable.lib; });

  flakey-profile = import (sources.flakey-profile + "/lib");

  custom-pkgs = import ../packages { inherit (pkgs) callPackage; };

  config = import ./config.nix { inherit pkgs; };
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
      pkgs-unstable.discord

      ## Educational
      anki

      ## Design
      inkscape
      aseprite

      ## Games
      gale
      heroic
      (prismlauncher.override {
        glfw3-minecraft = (glfw3-minecraft.override { withMinecraftPatch = true; });
      })
      waywall # minecraft speedrunning wayland compositor

      ## Music
      ardour
      guitarix
      beets
      ffmpeg # Beets replaygain method
      audacity
      mprisence # Discord MPRIS RPC

      ## Utility
      fd # nvim-telescope find file
      ripgrep
      tree-sitter
      texliveFull
      swayimg
      awww
      wayshot
      btop
      pkgs-unstable.matugen
      maestral # Dropbox Client
      (pkgs.wrapOBS {
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-pipewire-audio-capture
        ];
      })
      appimage-run

      ## Developement
      (android-studio.override {
        tiling_wm = true;
      })
      (vscodium-fhsWithPackages (
        ps: with ps; [
          stdenv.cc.libcxx
        ]
      ))
      godot-mono
      nixd
      nil
      nixfmt
      git-repo
      glab
      nix-direnv
      direnv

      ## Emulators
      cemu

      ## Theming
      tela-icon-theme
      adw-gtk3
      bibata-cursors
      marble-shell-theme

      ## Shell
      antidote
    ];
  };
}
