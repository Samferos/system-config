{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
{
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];
  hardware.nvidia.open = false;

  hardware.nvidia.prime = {
    offload.enable = true;
    offload.enableOffloadCmd = true;

    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  hardware.nvidia.modesetting.enable = true;

  specialisation.full-power.configuration = {
    system.nixos.tags = [ "full-power" ];
    hardware.nvidia.prime = {
      sync.enable = lib.mkForce true;
      offload.enable = lib.mkForce false;
      offload.enableOffloadCmd = lib.mkForce false;
    };
  };

  environment.systemPackages = with pkgs; [
    cudatoolkit
  ];
}
