{ config, ... }:
{
	imports = [
		./kernel.nix
		./boot.nix
	];

  networking.hostName = "bluerose";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = true;
  networking.wireguard.enable = true;
  networking.firewall = {
		enable = true;
		checkReversePath = false;
  };

  powerManagement.enable = true;

  services.thermald.enable = true;

  networking.nftables.enable = true;

  time.timeZone = "Europe/Paris";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  i18n =
    let
      textLanguage = "en_US.UTF-8";
      infoLanguage = "fr_FR.UTF-8";
    in
    {
      defaultLocale = "en_US.UTF-8";
      supportedLocales = [
        "en_US.UTF-8/UTF-8"
        "fr_FR.UTF-8/UTF-8"
      ];
      extraLocaleSettings = {
        LC_CTYPE = textLanguage;
        LC_ADDRESS = infoLanguage;
        LC_MEASUREMENT = infoLanguage;
        LC_MESSAGES = textLanguage;
        LC_MONETARY = infoLanguage;
        LC_NAME = infoLanguage;
        LC_NUMERIC = textLanguage;
        LC_PAPER = infoLanguage;
        LC_TELEPHONE = infoLanguage;
        LC_TIME = infoLanguage;
        LC_COLLATE = infoLanguage;
      };
    };
  console = {
    keyMap = "fr";
  };

  security.sudo.enable = false;
  security.doas = {
    enable = true;
  };
}
