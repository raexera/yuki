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
  };

  services = {
    playerctld.enable = true;
  };
}
