{ config, lib, pkgs, ... }:
let
  source = import ./npins;
  nixpkgs-unstable = ((import source.nixpkgs-unstable) { inherit (config.nixpkgs) config; });
in 
{
  imports = [
    ./hardware-configuration.nix
    ./core
    ./session
    ./overlays
    ./pinning.nix
  ];

  _module.args.pkgs-unstable = nixpkgs-unstable;

  nix = {
    package = pkgs.lixPackageSets.stable.lix;
    settings = {
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org/"
      ];
      trusted-public-keys = [ 
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-unwrapped"
      "cuda_cudart"
      "cuda_cccl"
      "cuda_nvcc"
      "libcublas"
      "cuda-merged"
      "cuda_cuobjdump"
      "cuda_gdb"
      "cuda_nvdisasm"
      "cuda_nvprune"
      "cuda_cupti"
      "cuda_cuxxfilt"
      "cuda_nvml_dev"
      "cuda_nvrtc"
      "cuda_nvtx"
      "cuda_profiler_api"
      "cuda_sanitizer_api"
      "libcufft"
      "libcurand"
      "libcusolver"
      "libcusparse"
      "libnpp"
      "libnvjitlink"
      "rar"
      "unrar"
      "nvidia"
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
      "open-webui"
    ];

  environment.pathsToLink = [ "/share/zsh" ];
  # to make system completions available for users

  system.stateVersion = "25.05"; # DO NOT CHANGE
}
