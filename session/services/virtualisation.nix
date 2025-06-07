{ pkgs, ... }:
{
	virtualisation.containers.enable = true;
	virtualisation.podman = {
		enable = true;

		defaultNetwork.settings.dns_enabled = true;

		dockerCompat = true;
	};

	environment.defaultPackages = with pkgs; [
		docker-compose
		podman-compose
		qemu
	];
}
