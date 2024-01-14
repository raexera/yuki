{pkgs, ...}: {
  imports = [
    ./scripts/preview.nix
    ./scripts/run-as-service.nix

    ./starship.nix
    ./zsh.nix
    ./git.nix
  ];

  home = {
    packages = with pkgs; [
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
      gnused
      hyperfine
      imagemagick
      jaq
      joshuto
      jq
      killall
      lz4
      neofetch
      p7zip
      perl
      procs
      psmisc
      ripgrep
      rsync
      sd
      socat
      trash-cli
      tree
      unrar
      unzip
      util-linux
      wget
      xarchiver
      yt-dlp
      zathura
      zip
    ];

    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
      NIX_AUTO_RUN = "1";
    };
  };

  programs = {
    bat.enable = true;
    btop.enable = true;
    eza.enable = true;
    gpg.enable = true;
    man.enable = true;
    ssh.enable = true;
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
  };

  services = {
    udiskie.enable = true;

    gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
      enableSshSupport = true;
      enableZshIntegration = true;
    };
  };
}
