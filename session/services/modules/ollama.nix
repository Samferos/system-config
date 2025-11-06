{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:

let
  inherit (lib) mkIf mkEnableOption mkOption mkMerge;
  cfg = config.session.services.ai;
in
{
  options.session.services.ai = {
    enable = mkEnableOption "Local AI Models with Ollama.";
    models = mkOption {
			type = lib.types.listOf lib.types.str;
			default = [ "gemma3:latest" ];
		};
    useNvidia = mkEnableOption "Using Nvidia CUDA acceleration.";
  };

  config = mkIf cfg.enable {
    services.ollama = mkMerge [
      {
        package = pkgs-unstable.ollama-cuda.overrideAttrs (
          final: prev: {
            preBuild = ''
              cmake -B build \
                -DCMAKE_SKIP_BUILD_RPATH=ON \
                -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
                -DCMAKE_CUDA_ARCHITECTURES='61' \

              cmake --build build -j $NIX_BUILD_CORES
            '';
          }
        );
        enable = true;
        loadModels = cfg.models;
      }
      (mkIf cfg.useNvidia {
        acceleration = "cuda";
      })
    ];

    virtualisation = {
      podman = {
        enable = true;
      };
      oci-containers = {
        backend = "podman";
        containers = {
          open-webui = {
            image = "ghcr.io/open-webui/open-webui:main";

            volumes = [
              "open-webui:/app/backend/data"
            ];

            environment =
            let
              inherit (config.services.ollama) host port;
              _port = builtins.toString port;
            in
            {
              "TZ" = "Europe/Paris";
              "OLLAMA_API_BASE_URL" = "http://${host}:${_port}/api";
              "OLLAMA_BASE_URL" = "http://${host}:${_port}";
              "WEBUI_AUTH" = "False";
            };

            extraOptions = [
              "--pull=newer"
              "--name=open-webui"
              "--hostname=open-webui"
              "--network=host"
            ];

            ports = [ "127.0.0.1:3000:8080" ];
          };
        };
      };
    };

    environment.systemPackages = mkIf cfg.useNvidia (
      with pkgs;
      [
        cudatoolkit
      ]
    );
  };
}
