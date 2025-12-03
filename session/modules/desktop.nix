{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:

with lib;

let
  cfg = config.session.desktop;
  windowManagers = [
    "sway"
    "niri"
  ];
  desktopEnvironments = [
    "kde"
  ];
  desktops = windowManagers ++ desktopEnvironments;

in
{
  options.session.desktop = {
    name = mkOption {
      description = ''
        		  The name of the desired desktop.
        		  '';
      type = types.enum desktops;
      default = "sway";
    };

    terminalEmulator = mkPackageOption pkgs "terminal-emulator" {
      default = "alacritty";
    };
  };

  config =
    let
      windowManagerOptions = {
        environment.systemPackages = with pkgs; [
          swayidle
          swaylock
          swaybg
          grim
          slurp
          waybar
          mako
          nautilus
          wofi
          file-roller
          evince
          baobab
          gnome-font-viewer
          gnome-clocks
          gnome-calculator
          gnome-characters
          batsignal
          simple-scan
          libnotify
          gsettings-desktop-schemas
          cfg.terminalEmulator
        ];

        programs.nautilus-open-any-terminal = {
          enable = true;
          terminal = getName cfg.terminalEmulator;
        };

        xdg.terminal-exec = {
          enable = true;
          settings = {
            default = [
              "${getName cfg.terminalEmulator}.desktop"
            ];
          };
        };
        programs.nm-applet.enable = true;
        programs.gnome-disks.enable = true;
        services.blueman.enable = true;
        security.soteria.enable = true; # Polkit GUI front-end

        services.xserver.displayManager.gdm = {
          enable = true;
          wayland = true;
        };

        environment.sessionVariables = {
          NIXOS_OZONE_WL = 1;
        };

        i18n.inputMethod = {
          enable = true;
          type = "ibus";
          ibus.engines = with pkgs.ibus-engines; [
            mozc-ut
          ];
        };

        # services.redshift = {
        #   enable = true;
        #   package = pkgs.gammastep;
        #   executable = "/bin/gammastep";
        #   temperature.day = 6500;
        # };

        # services.geoclue2 = {
        #   enable = true;
        #   enableWifi = true;
        #   enableNmea = false;
        # };

        # location.provider = "geoclue2";
      };
    in
    mkMerge [
      # General options (for window managers & DEs)
      {
        environment.systemPackages = with pkgs; [
          wayland-utils
          wl-clipboard
        ];

        services.displayManager = {
          enable = true;
        };
      }

      ## Window managers
      (mkIf (builtins.elem cfg.name windowManagers) (mkMerge [
        windowManagerOptions

        (mkIf (cfg.name == "sway") {
          programs.sway = {
            enable = true;
            wrapperFeatures.gtk = true;
            package = pkgs-unstable.swayfx;
            extraPackages = with pkgs; [
              swayws
            ];
            extraOptions = [
              "--unsupported-gpu"
            ];
          };

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

        (mkIf (cfg.name == "niri") {
          programs.niri.enable = true;

          environment.systemPackages = with pkgs; [
            xwayland-satellite
          ];
        })
      ]))

      ## Desktop environments
      (mkIf (cfg.name == "kde") {
        services.desktopManager.plasma6.enable = true;
        services.displayManager.sddm = {
          enable = true;
          wayland.enable = true;
        };

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

        i18n.inputMethod = {
          enable = true;
          type = "fcitx5";
          fcitx5.addons = with pkgs; [
            fcitx5-gtk
            fcitx5-mozc-ut
          ];
          fcitx5.waylandFrontend = true;
        };
      })
    ];
}
