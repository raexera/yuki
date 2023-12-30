{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    pavucontrol
    playerctl
    pulsemixer
    amberol
    loupe
    celluloid
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
