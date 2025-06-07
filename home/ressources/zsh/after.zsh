nix-find-store() {
	find /nix/store/ -maxdepth 1 -regex ".*${1}.*";
}
