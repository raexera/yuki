{pkgs, ...}: {
  home.packages = with pkgs; [
    imv
    mpg123
    mpc_cli
    pavucontrol
    playerctl
    pulsemixer
  ];

  programs = {
    mpv = {
      enable = true;
      defaultProfiles = ["gpu-hq"];
      bindings = {
        UP = "add volume +2";
        DOWN = "add volume -2";
      };
      config = {
        hwdec = "auto";
        border = false;
      };
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
    "audio/*" = "mpv.desktop";
    "video/*" = "mpv.desktop";
    "image/*" = "imv.desktop";
  };
}
