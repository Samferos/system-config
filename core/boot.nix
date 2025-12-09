{ pkgs, lib, ... }:
{
	## Bootloader

  boot.loader.systemd-boot = {
    enable = false;
    consoleMode = "max";
  };
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.limine = {
    enable = true;
    secureBoot.enable = true;
    style = {
      wallpapers = [];
      wallpaperStyle = "centered";
      interface = {
        helpHidden = true;
        brandingColor = 7;
        branding = "";
      };
      graphicalTerminal = {
        palette = "585b70;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4";
        brightPalette = "1e1e2e;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4";
        background = "1e1e2e";
        foreground = "cdd6f4";
        brightBackground = "585b70";
        brightForeground = "cdd6f4";
      };
    };
  };

  boot.plymouth.enable = true;
}
