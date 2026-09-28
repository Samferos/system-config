{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];
  hardware.nvidia = {
    open = false;
    branch = "legacy_580";
    modesetting.enable = true;
    powerManagement.enable = true;

    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;

      intelBusId = "PCI:0@0:2:0";
      nvidiaBusId = "PCI:1@0:0:0";
    };
  };

  specialisation.full-power.configuration = {
    system.nixos.tags = [ "full-power" ];
    hardware.nvidia.prime = {
      sync.enable = lib.mkForce true;
      offload.enable = lib.mkForce false;
      offload.enableOffloadCmd = lib.mkForce false;
    };
  };
}
