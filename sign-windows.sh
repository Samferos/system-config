#!/usr/bin/env nix-shell
#!nix-shell -i sh -p sbctl

doas find /boot/EFI/Microsoft/Boot -type f -exec $(which sbctl) sign {} \;
