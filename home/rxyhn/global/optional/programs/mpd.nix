{
  config,
  pkgs,
  ...
}: {
  services.mpd = {
    enable = true;
    musicDirectory = "${config.xdg.userDirs.music}";
    extraConfig = ''
      auto_update           "yes"
      restore_paused        "yes"

      audio_output {
      	type                "pipewire"
      	name                "PipeWire Sound Server"
      	buffer_time         "100000"
      }

      audio_output {
      	type                "fifo"
      	name                "Visualizer"
      	format              "44100:16:2"
      	path                "/tmp/mpd.fifo"
      }

      audio_output {
      	type		            "httpd"
      	name		            "lossless"
      	encoder		          "flac"
      	port		            "8000"
      	max_client	        "8"
      	mixer_type	        "software"
      	format		          "44100:16:2"
      }
    '';
  };

  services.mpdris2 = {
    enable = true;
    mpd.host = "127.0.0.1";
  };
}
