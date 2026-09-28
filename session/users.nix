{ pkgs, ... }:

{
  users.users.samuel = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "networkmanager" "adbusers" "music" ];
  };

  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    # completion system-wide slows startup
    # when using home-manager
  };
}
