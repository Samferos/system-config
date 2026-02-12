{
  config,
  pkgs,
  lib,
  ...
}:
{
  boot.kernelParams = [
    "pci=nommconf"
    "quiet"
    "splash"
  ];

  boot.consoleLogLevel = 3;

  #boot.kernelPatches = [
  #  {
  #    name = "nofbcon-config";
  #    patch = null;
  #    structuredExtraConfig = with lib.kernel; {
  #      FRAMEBUFFER_CONSOLE = lib.mkForce no;
  #      FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER = lib.mkForce unset;
  #      FRAMEBUFFER_CONSOLE_ROTATION = lib.mkForce unset;
  #      FRAMEBUFFER_CONSOLE_DETECT_PRIMARY = lib.mkForce unset;
  #    };
  #  }
  #];

  specialisation.debug.configuration = {
    boot.kernelParams = lib.mkForce [ ];
    boot.kernelPatches = lib.mkForce [ ];
    boot.consoleLogLevel = lib.mkForce 3;
  };

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];

  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';

  boot.kernelPackages = pkgs.linuxPackages_latest;
}
