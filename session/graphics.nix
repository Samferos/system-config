{ pkgs, config, lib, ... }:
{
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];
  hardware.nvidia.open = false;

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

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

	environment.sessionVariables = {
	  __NV_PRIME_RENDER_OFFLOAD=1;
      __NV_PRIME_RENDER_OFFLOAD_PROVIDER="NVIDIA-G0";
      __GLX_VENDOR_LIBRARY_NAME="nvidia";
      __VK_LAYER_NV_optimus="NVIDIA_only";
	};
  };

  environment.systemPackages = with pkgs; [
    cudatoolkit
  ];
}
