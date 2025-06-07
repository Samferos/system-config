{ lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./core
    ./session
    ./pinning.nix
    (
      let
        sources = import ./npins;
        lix-module = sources.lix-module;
        lix = sources.lix;
      in
      import "${lix-module}/module.nix" { inherit lix; }
    )
  ];

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
    ];

  environment.pathsToLink = [ "/share/zsh" ];
  # to make system completions available for users

  system.stateVersion = "25.05"; # DO NOT CHANGE
}
