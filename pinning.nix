let
  sources = import ./npins;
in 
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.registry.nixpkgs.to = {
    type = "path";
    path = sources.nixpkgs;
  };

  nix.nixPath = [
    "nixpkgs=flake:nixpkgs"
    "nixpkgs-unstable=${sources.nixpkgs-unstable}"
	"nixpkgs-overlays=${builtins.toString ./core/overlays}"
    "nixos-config=${builtins.toString ./configuration.nix}"
  ];
}
