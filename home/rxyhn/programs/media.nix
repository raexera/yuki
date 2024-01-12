{pkgs, ...}: {
  home.packages = with pkgs; [
    amberol
    celluloid
    imv
    loupe
    pavucontrol
    playerctl
    pulsemixer
  ];

  programs = {
    mpv = {
      enable = true;
      defaultProfiles = ["gpu-hq"];
      scripts = with pkgs.mpvScripts; [mpris thumbnail sponsorblock];
    };

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [wlrobs];
    };
  };

  services = {
    playerctld.enable = true;
  };

  xdg.mimeApps.defaultApplications = {
    "audio/*" = "io.bassi.Amberol";
    "image/*" = "org.gnome.Loupe";
    "video/*" = "io.github.celluloid_player.Celluloid";
  };
}
