#!/usr/bin/env bash

cd $(dirname $0)

command=${1:-switch}
shift

nixpkgs_pin=$(nix eval --raw -f npins/default.nix nixpkgs)
nix_path="nixpkgs=${nixpkgs_pin}:nixos-config=${PWD}/configuration.nix"

doas env NIX_PATH="${nix_path}" nixos-rebuild "$command" --fast "$@"
