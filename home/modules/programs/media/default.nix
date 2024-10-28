{pkgs, ...}: {
  imports = [
    ./mpv.nix
    ./obs-studio.nix
    ./playerctld.nix
    ./rnnoise.nix
  ];

  home.packages = with pkgs; [
    amberol
    celluloid
    imv
    loupe
    pavucontrol
    playerctl
    pulsemixer
    foliate
  ];
}
