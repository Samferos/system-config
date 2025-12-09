{
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

  # hardware.nvidia.package = pkgs-unstable.linuxPackages_latest.nvidiaPackages.stable;
  # FIXME: very wacky, should not be disjointed from
  # core/kernel.nix

  hardware.nvidia.prime = {
    offload.enable = true;
    offload.enableOffloadCmd = true;

    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  specialisation.full-power.configuration = {
    system.nixos.tags = [ "full-power" ];
    hardware.nvidia.prime = {
      sync.enable = lib.mkForce true;
      offload.enable = lib.mkForce false;
      offload.enableOffloadCmd = lib.mkForce false;
    };

    hardware.nvidia.modesetting.enable = lib.mkForce true;
  };

  environment.systemPackages = with pkgs; [
    cudatoolkit
  ];
}
