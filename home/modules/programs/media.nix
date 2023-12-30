{
  pkgs,
  config,
  ...
}:
# media - control and enjoy audio/video
{
  imports = [
    ./rnnoise.nix
    ./spicetify.nix
  ];

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
