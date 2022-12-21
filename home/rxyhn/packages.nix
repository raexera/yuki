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
    alsa-lib
    alsa-plugins
    alsa-tools
    alsa-utils
    bandwhich
    bc
    blueberry
    cairo
    cached-nix-shell
    cinnamon.nemo
    coreutils
    dconf
    findutils
    ffmpeg-full
    fzf
    glib
    glxinfo
    gnumake
    gnuplot
    gnused
    gnutls
    grex
    hyperfine
    imagemagick
    inotify-tools
    keepassxc
    killall
    libappindicator
    libnotify
    libsecret
    libreoffice-fresh
    mpv-unwrapped
    nodejs
    pamixer
    psmisc
    pavucontrol
    pulseaudio
    python3
    rsync
    todo
    trash-cli
    util-linux
    wirelesstools
    xarchiver
    xclip
    xdg-utils
    xh
    xorg.xhost
    zoom-us
  ];
}
