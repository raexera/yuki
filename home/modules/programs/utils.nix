{pkgs, ...}: {
  home.packages = with pkgs; [
    atool
    bc
    catimg
    chafa
    coreutils
    curl
    du-dust
    duf
    editorconfig-core-c
    elinks
    exiftool
    fd
    file
    findutils
    gawk
    glow
    gnumake
    gnused
    hyperfine
    imagemagick
    jaq
    jq
    killall
    lz4
    neofetch
    nvd
    p7zip
    procs
    psmisc
    ripgrep
    rsync
    sd
    socat
    trash-cli
    ttyper
    unrar
    unzip
    util-linux
    wget
    xarchiver
    yt-dlp
    zathura
    zip
  ];

  programs = {
    bat.enable = true;
    eza.enable = true;
    man.enable = true;
    tmux.enable = true;

    dircolors = {
      enable = true;
      enableZshIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    thefuck = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
