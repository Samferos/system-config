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
		"nixpkgs-overlays=${./core/overlays}"
  ];
}
