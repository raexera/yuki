{pkgs, ...}: {
  imports = [
    ./dev
  ];

  home.packages = with pkgs; [
    bc
    coreutils
    curl
    du-dust
    duf
    editorconfig-core-c
    fd
    ffmpeg-full
    ffmpegthumbnailer
    file
    findutils
    gawk
    glow
    gnumake
    gnused
    imagemagick
    jaq
    jq
    killall
    p7zip
    pre-commit
    procs
    psmisc
    ripgrep
    rsync
    tree
    unrar
    unzip
    util-linux
    vim
    watchexec
    wget
    wrk
    xh
    yt-dlp
    yq
    zip
  ];
}
