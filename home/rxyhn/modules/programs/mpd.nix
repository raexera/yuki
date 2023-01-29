{pkgs, ...}: {
  services.mpd = {
    enable = true;
    network = {
      listenAddress = "any";
      port = 6600;
    };

    extraConfig = ''
      audio_output {
        type    "pipewire"
        name    "pipewire"
      }
      auto_update "yes"
    '';
  };

  services.mpdris2 = {
    enable = true;
    notifications = true;
    mpd = {
      host = "127.0.0.1";
    };
  };
}
