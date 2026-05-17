#!/usr/bin/env bash

cd $(dirname $0)

command=${1:-switch}
shift

nixpkgs_pin=$(nix eval --raw -f npins/default.nix nixpkgs)
nix_path="nixpkgs=${nixpkgs_pin}:nixos-config=${PWD}/configuration.nix"

doas env NIX_PATH="${nix_path}" nixos-rebuild "$command" --no-reexec "$@"

echo "Commit changes ? (git commit -a)"
echo "[Y/n]"

update_done=''
until [ "$update_done" ]; do
  read -r ANSWER
  
  case $ANSWER in
    y | Y | yes | Yes | YES | '')
      git commit -a
      update_done=1
      ;;
    n | N | no | No | NO)
      update_done=1
      ;;
    *)
      echo 'Invalid input. Please enter y or n.'
      ;;
  esac
done
