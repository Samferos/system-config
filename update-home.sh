#!/usr/bin/env bash

cd $(dirname $0)

nixpkgs_pin=$(nix eval --raw -f npins/default.nix nixpkgs)
nix_path="nixpkgs=${nixpkgs_pin}"

if [[ $# -lt 1 ]]; then
	echo 'No arguments were provided.'
	exit 1
fi

env NIX_PATH=${nix_path} nix run -f ./home "profile.${1:-switch}"
