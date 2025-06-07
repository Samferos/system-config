{ pkgs, lib, ... }:
# let
#   sources = import ../npins;
# 	lanzaboote = import sources.lanzaboote;
# in 
{
	# imports = [ lanzaboote.nixosModules.lanzaboote ];

	## Secure boot

	# environment.systemPackages = [
	# 	pkgs.sbctl
	# ];

	# systemd-boot module is replaced by lanzaboote.
	# so we force it off.
	# boot.loader.systemd-boot.enable = lib.mkForce false;

	# boot.lanzaboote = {
	# 	enable = true;
	# 	pkiBundle = "/var/lib/sbctl";
	# };

	## Bootloader

  boot.loader.systemd-boot = {
    enable = true;
    consoleMode = "max";
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;
}
