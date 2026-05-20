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
      discord

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
      (surge-XT.override {
      	# nixpkgs has an accidental negation on this param so it doesn't build it by default
      	buildLV2 = false;
      })
      guitarix
      pkgs-unstable.beets # Stable version has a vulnerability
      ffmpeg # Beets replaygain method
      audacity
      mprisence # Discord MPRIS RPC

      ## Utility
      fd # nvim-telescope find file
      ripgrep
      tree-sitter
      texliveFull
      swayimg
      swww
      wayshot
      btop
      pkgs-unstable.matugen
      bitwarden-desktop
      maestral
      blender
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
      nixfmt-rfc-style
      git-repo
      glab
      nix-direnv
      direnv
      pkgs-unstable.pragtical

      ## Emulators
      cemu
      pkgs-unstable.ryubing

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
