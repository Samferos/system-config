{ pkgs, lib, ... }:

let
  sources = import ../npins;
  pkgs-unstable = import sources.nixpkgs-unstable {
    config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "blender"
        "cuda_cudart"
        "cuda_cccl"
        "cuda_nvcc"
      ];
  };
in
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      hm = "home-manager";
      update = "sudo nixos-rebuild switch";
    };

    antidote = {
      enable = true;
      plugins = [
        "jeffreytse/zsh-vi-mode"
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-syntax-highlighting"
      ];
    };

    initContent = builtins.readFile ./ressources/zsh/after.zsh;

    enableCompletion = true;
  };

  programs.pay-respects = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--alias"
      "fuck"
    ];
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.git = {
    enable = true;
    userEmail = "samuel.antunes@etu.univ-nantes.fr";
    userName = "Samuel AMARAL ANTUNES";
    extraConfig = {
      pull.rebase = false;
    };
  };

  programs.ssh = {
    enable = true;
  };

  programs.beets = {
    enable = true;
    settings = {
      library = "/home/samuel/Music/Collection/.library.db";
      directory = "/home/samuel/Music/Collection";
      move = "yes";
      plugins = builtins.concatStringsSep " " [
        "fetchart"
        "replaygain"
        "embedart"
        "thumbnails"
        "edit"
        "hook"
        "permissions"
      ];
      embedart = {
        auto = "no";
      };
      replaygain = {
        auto = "yes";
        backend = "ffmpeg";
        albumgain = "yes";
      };
      hooks = [
        {
          event = "import";
          command = "beet clearart {' '.join(paths)}";
        }
      ];
      permissions = {
        file = "775";
        dir = "775";
      };
    };
  };

  programs.lazygit.enable = true;

  home.packages = with pkgs; [
    nixd
    nixfmt-rfc-style
    matugen
    discord
    imv
    git-repo
    swww
    wayshot
    godot-mono
    btop
    cemu
    pkgs-unstable.heroic
    prismlauncher
    # obs-studio
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-pipewire-audio-capture
      ];
    })
    inkscape
    penpot-desktop
    gale
    ardour
    guitarix
    fd # nvim-telescope find file
    ripgrep
    tree-sitter
    ffmpeg # Beets replaygain method
    texliveFull
    #android-studio
    bitwarden
    audacity
    (pkgs-unstable.blender.override {
      cudaSupport = true;
    })

    ryubing
    tela-icon-theme
  ];
}
