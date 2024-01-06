{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./scripts

    ./starship.nix
    ./zsh.nix
    ../programs/git.nix
  ];

  home = {
    packages = with pkgs; [
      bc
      catimg
      coreutils
      curl
      du-dust
      duf
      editorconfig-core-c
      fd
      file
      findutils
      gawk
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
      ranger
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
      zathura
      zip
    ];

    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
      NIX_AUTO_RUN = "1";
    };
  };

  programs = {
    btop.enable = true;
    eza.enable = true;
    gpg.enable = true;
    man.enable = true;
    ssh.enable = true;

    bat = {
      enable = true;
      config = {
        pager = "less -FR";
        style = "plain";
        theme = "base16";
      };
    };

    dircolors = {
      enable = true;
      enableZshIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };

    skim = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "rg --files --hidden";
      changeDirWidgetOptions = [
        "--preview 'eza --icons --git --color always -T -L 3 {} | head -200'"
        "--exact"
      ];
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

    ssh-agent.enable = true;
  };
}
