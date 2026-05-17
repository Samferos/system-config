{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  npins-sources,
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
    "gnome"
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
          swayimg
          grim
          slurp
          waybar
          mako
          nautilus
          rofi
          file-roller
          evince
          baobab
          gnome-font-viewer
          gnome-clocks
          gnome-calculator
          gnome-characters
          gnome-text-editor
          batsignal
          simple-scan
          libnotify
          gsettings-desktop-schemas
        ];

        programs.nautilus-open-any-terminal = {
          enable = true;
          terminal = getName cfg.terminalEmulator;
        };

        programs.nm-applet.enable = true;
        programs.gnome-disks.enable = true;
        services.blueman.enable = true;
        security.soteria.enable = true; # Polkit GUI front-end

        services.displayManager.gdm = {
          enable = true;
        };

        environment.sessionVariables = {
          NIXOS_OZONE_WL = 1;
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
            cfg.terminalEmulator
          ];

          services.displayManager = {
            enable = true;
          };

          xdg.terminal-exec = {
            enable = true;
            settings = {
              default = [
                "${getName cfg.terminalEmulator}.desktop"
              ];
            };
          };
        }

        ## Window managers
        (mkIf (builtins.elem cfg.name windowManagers) (mkMerge [
          windowManagerOptions

          (mkIf (cfg.name == "sway") {
            programs.sway = {
              enable = true;
              wrapperFeatures.gtk = true;
              package = pkgs.swayfx;
              extraPackages = with pkgs; [
                swayws
              ];
              extraOptions = [
                "--unsupported-gpu"
              ];
            };

            environment.sessionVariables = {
              WLR_RENDERER = "vulkan";
            };

            environment.etc."libinput/local-overrides.quirks".text = ''
            [Mouse Debouncing]
            MatchUdevType=mouse
            ModelBouncingKeys=1
            '';

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
            programs.niri = {
              enable = true;
              package = pkgs-unstable.niri;
            };

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

        (mkIf (cfg.name == "gnome") {
          services.displayManager.gdm.enable = true;
          services.desktopManager.gnome.enable = true;
          services.gnome.games.enable = false;

          environment.gnome.excludePackages = with pkgs; [
            showtime
            epiphany
            geary
            gnome-connections
            gnome-console
            gnome-music
            gnome-tour
            gnome-user-docs
            gnome-builder
            yelp
          ];
          
          i18n.inputMethod = {
            enable = false;
            type = "ibus";
            ibus.engines = with pkgs.ibus-engines; [
              mozc-ut
            ];
          };
          
          programs.nautilus-open-any-terminal = {
            enable = true;
            terminal = getName cfg.terminalEmulator;
          };
        })
      ];
}
