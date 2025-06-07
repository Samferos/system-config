{ lib, ... }:

{
  imports = [
    ./programs.nix
    ./services.nix
    ./session.nix
  ];

  home.username = "samuel";
  home.homeDirectory = "/home/samuel";

  home.stateVersion = "25.05"; # DO NOT CHANGE

  home.file = {
    ## TODO Version dotfiles
  };

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
      "android-studio-stable"
    ];

  nixpkgs.overlays = [
    (final: prev: {
      discord = prev.discord.override { withVencord = true; };
      vencord = prev.vencord.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [
          ./ressources/patches/Revert-Delete-Moyai-plugin.patch
        ];
      });
    })
  ];

  home.shell.enableZshIntegration = true;

  programs.home-manager.enable = true;
}
