{ config, ... }:
let
  musicFolder = "/usr/share/music";
in
{
  ## Syncing to phone
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    settings = rec {
      devices = {
        "Mizuki" = {
          id = "N2EK2FR-PMRE5ST-EA6SEMR-V7QU342-TWSYJ57-KXRVUYW-ZDVQY34-KORYQQS";
        };
      };
      folders = {
        "Music" = {
          path = musicFolder;
          ignorePerms = true;
          devices = builtins.attrNames devices;
        };
      };
    };
  };

  # For folders to be writable by the users group
  systemd.services.syncthing.serviceConfig.UMask = "002";

  systemd.tmpfiles.settings = {
    "10-syncthing" = {
      ${musicFolder} = {
        d = {
          group = "users";
          mode = "2775";
          user = "syncthing";
        };
      };
    };
  };
}
