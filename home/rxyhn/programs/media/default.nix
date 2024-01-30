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
  ];

  xdg.mimeApps.defaultApplications = {
    "audio/*" = "io.bassi.Amberol";
    "image/*" = "org.gnome.Loupe";
    "video/*" = "io.github.celluloid_player.Celluloid";
  };
}
