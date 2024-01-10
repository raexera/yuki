{
  config,
  pkgs,
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
    btop.enable = true;
    eza.enable = true;
    gpg.enable = true;
    man.enable = true;
    ssh.enable = true;

    bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "catppuccin-macchiato";
      };
      themes = {
        catppuccin-macchiato = {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
            sha256 = "6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
          };
          file = "Catppuccin-macchiato.tmTheme";
        };
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
  };
}
