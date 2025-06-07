{
  config,
  pkgs,
  lib,
  ...
}:
let
  sources = import ../../npins;
  nixpkgs-unstable = import sources.nixpkgs-unstable { };

  cfg = config.session.desktop;
  desktops = [
    "sway"
    "kde"
  ];
in
{
  options.session.desktop = {
    name = lib.mkOption {
      description = ''
        		  The name of the desired desktop.
        		  '';
      type = lib.types.enum desktops;
      default = "sway";
    };
  };

  config = lib.mkMerge [
    {
      environment.systemPackages = with pkgs; [
        wayland-utils
        wl-clipboard
      ];
    }
    (lib.mkIf (cfg.name == "sway") {
      programs.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
        package = nixpkgs-unstable.swayfx;
        extraPackages = with pkgs; [
          # These programs end up in environment.systemPackages.
          swayidle
          swaylock
          swayws
          grim
          slurp
          waybar
          mako
          wofi
          nautilus
		  nautilus-open-any-terminal
          file-roller
          evince
          baobab
          gnome-font-viewer
          gnome-clocks
          gnome-calculator
          gnome-characters
          batsignal
          simple-scan
        ];
        extraOptions = [
          "--unsupported-gpu"
        ];
      };

      programs.nm-applet.enable = true;
      programs.gnome-disks.enable = true;

      services.blueman.enable = true;
      security.soteria.enable = true; # Polkit GUI front-end

      programs.uwsm = {
        enable = true;
        waylandCompositors = {
          sway = {
            prettyName = "sway";
            comment = "an i3 compatible wayland compositor";
            binPath = "/run/current-system/sw/bin/sway";
          };
        };
      };

    })
    (lib.mkIf (cfg.name == "kde") {
      services.desktopManager.plasma6.enable = true;

      environment.systemPackages = with pkgs; [
        kdePackages.kcalc
        kdePackages.kcharselect
        kdePackages.kcolorchooser
        kdePackages.kolourpaint
        kdePackages.ksystemlog
        kdePackages.sddm-kcm
        kdiff3
        kdePackages.isoimagewriter
        kdePackages.partitionmanager
        hardinfo2
        haruna
      ];

      environment.plasma6.excludePackages = with pkgs.kdePackages; [
        plasma-browser-integration
        kdepim-runtime
        konsole 
        oxygen
		discover
      ];
    })
  ];
}
