{ config, pkgs, lib, ... }:
let
  sources = import ../npins;
  # nixpkgs-unstable = import sources.nixpkgs-unstable {
  #   config.allowUnfreePredicate =
  #     pkg:
  #     builtins.elem (lib.getName pkg) [
  #       "nvidia"
  #       "nvidia-x11"
  #       "nvidia-settings"
  #       "nvidia-persistenced"
  #     ];
  # };
in
{
	boot.kernelPackages = pkgs.linuxPackages_latest;

	# boot.extraModulePackages = with config.boot.kernelPackages; [
	# 	v4l2loopback
	# ];
	# boot.extraModprobeConfig = ''
    # options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  	# '';
	security.polkit.enable = true;

	# boot.kernelParams = [
	# 	"pci=nommconf"
	# ];
}
