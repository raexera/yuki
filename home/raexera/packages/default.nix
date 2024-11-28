{pkgs, ...}: {
  imports = [
    ./dev
  ];

  home.packages = with pkgs; [
    coreutils
    curl
    du-dust
    duf
    editorconfig-core-c
    fd
    ffmpeg-full
    ffmpegthumbnailer
    file
    file-roller
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
    trash-cli
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
