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
    fd
    findutils
    editorconfig-core-c
    file
    hyperfine
    joshuto
    jq
    killall
    lm_sensors
    lz4
    man-pages
    man-pages-posix
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

  services = {
    syncthing.enable = true;

    gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
      enableZshIntegration = true;
      enableSshSupport = true;
    };
  };

  programs = {
    ssh.enable = true;
    exa.enable = true;

    gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnupg";
    };

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
