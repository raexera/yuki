{
  inputs,
  pkgs,
  config,
  ...
}: let
  mpv-unwrapped = pkgs.mpv-unwrapped.overrideAttrs (o: {
    src = pkgs.fetchFromGitHub {
      owner = "mpv-player";
      repo = "mpv";
      rev = "48ad2278c7a1fc2a9f5520371188911ef044b32c";
      sha256 = "sha256-6qbv34ysNQbI/zff6rAnVW4z6yfm2t/XL/PF7D/tjv4=";
    };
  });
in {
  home.packages = with pkgs; [
    # Apps
    cinnamon.nemo
    libsForQt5.qtstyleplugin-kvantum
    mpv-unwrapped
    yt-dlp
    zoom-us

    # CLI Tools
    bandwhich
    cachix
    dconf
    docker-compose
    docker-credential-helpers
    glxinfo
    grex
    hyperfine
    keepassxc
    killall
    lm_sensors
    todo
    trash-cli
    xorg.xhost
  ];
}
