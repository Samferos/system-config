{ config, lib, ... }:

let
  cfg = config.session.services.ai;
in
{
  options.session.services.ai = {
    enable = lib.mkEnableOption "Local AI Models with Ollama.";
    models = lib.mkOption {
			type = lib.types.listOf lib.types.str;
			default = [ "deepseek-r1:latest" ];
		};
    useNvidia = lib.mkEnableOption "Using Nvidia CUDA acceleration.";
  };

  config = lib.mkIf cfg.enable {
    services.ollama = {
      enable = true;
      acceleration = lib.mkIf cfg.useNvidia "cuda";
			loadModels = cfg.models;
    };
  };
}
