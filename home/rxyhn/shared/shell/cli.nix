{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    bc
    bandwhich
    bottom
    btop
    catimg
    coreutils
    curl
    du-dust
    duf
    editorconfig-core-c
    fd
    findutils
    file
    hyperfine
    imv
    joshuto
    jq
    killall
    lm_sensors
    lz4
    man-pages
    man-pages-posix
    mpc_cli
    mpg123
    neofetch
    pciutils
    perl
    procs
    psmisc
    p7zip
    ranger
    ripgrep
    rsync
    sd
    trash-cli
    tree
    unrar
    unzip
    util-linux
    wget
    xarchiver
    zip
    yt-dlp
  ];

  programs = {
    exa.enable = true;
    gpg.enable = true;
    man.enable = true;
    ssh.enable = true;

    bat = {
      enable = true;
      config = {
        pager = "never";
        style = "plain";
        theme = "base16";
      };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    dircolors = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
