#!/usr/bin/env bash

cd $(dirname $0)

nixpkgs_pin=$(nix eval --raw -f npins/default.nix nixpkgs)
hm_pin=$(nix eval --raw -f npins/default.nix home-manager)
nix_path="nixpkgs=${nixpkgs_pin}:home-manager=${hm_pin}"

# Old Home-manager config (ew)
# env NIX_PATH=${nix_path} home-manager -f ${PWD}/home/home.nix "$@"

if [[ $# -lt 1 ]]; then
	echo 'No arguments were provided.'
	exit 1
fi

env NIX_PATH=${nix_path} nix run -f ./home/experimental-profile "profile.$1"
