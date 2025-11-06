{ pkgs, ... }:
{
  imports = [
    ./music.nix
    ./virtualisation.nix
    ./modules/ollama.nix
  ];

  session.services.ai = {
    enable = true;
    useNvidia = true;
  };

  ## Printing
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
    ];
  };

  ## Scanning
  hardware.sane.enable = true;

  ## Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  ## Filesystems
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  ## Keyring
  services.gnome.gnome-keyring.enable = true;

  ## Bluetooth
  hardware.bluetooth.enable = true;

  ## Flatpak
  services.flatpak.enable = true;
}
