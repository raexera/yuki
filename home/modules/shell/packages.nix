{pkgs, ...}: {
  home.packages = with pkgs; [
    atac
    atool
    brightnessctl
    coreutils
    curl
    du-dust
    duf
    editorconfig-core-c
    elinks
    fd
    file
    findutils
    gawk
    glow
    gnumake
    gnused
    imagemagick
    jaq
    jq
    kaniko
    killall
    kubeshark
    p7zip
    pre-commit
    procs
    playerctl
    psmisc
    ripgrep
    rsync
    skaffold
    termshark
    trash-cli
    unrar
    unzip
    util-linux
    vim
    watchexec
    wget
    wrk
    xarchiver
    xh
    yt-dlp
    yq
    zathura
    zip
  ];
}
