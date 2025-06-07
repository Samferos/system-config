{
  services.podman.enable = true;

  services.mpd = {
    enable = true;
    musicDirectory = "/usr/share/home/Music/";
    network.startWhenNeeded = true;
    extraConfig = ''
      		audio_output {
      			type "pipewire"
      			name "mpd_pipewire_out"
      		}
      		'';
  };

  services.mpd-discord-rpc = {
    enable = true;
    settings = {
      id = 1417232117300990004;
      hosts = [ "localhost:6600" ];
      format = {
        details = "$title";
        state = "$artist / $album";
        timestamp = "elapsed";
        large_image = "notes";
        small_image = "notes";
        large_text = "";
        small_text = "";
      };
    };
  };
}
