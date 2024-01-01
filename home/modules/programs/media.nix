{pkgs, ...}: {
  home.packages = with pkgs; [
    pavucontrol
    playerctl
    pulsemixer
    amberol
    loupe
    celluloid
    mpc_cli
    mpg123
  ];

  programs = {
    mpv = {
      enable = true;
      defaultProfiles = ["gpu-hq"];
      scripts = [pkgs.mpvScripts.mpris];
    };

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studioPlugins; [
        obs-advanced-scene-switcher
        obs-browser
        obs-ffmpeg
        obs-filters
        obs-ndi
        obs-streamfx
        obs-transitions
        obs-v4l2sink
        obs-xdg-portal
      ];
    };
  };

  services = {
    playerctld.enable = true;
  };
}
