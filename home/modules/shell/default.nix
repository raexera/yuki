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
    ../programs/xdg.nix
  ];

  home = {
    packages = with pkgs; [
      zip
      unzip
      unrar
      du-dust
      duf
      fd
      file
      jaq
      ripgrep
    ];

    sessionVariables = {
      LESSHISTFILE = config.xdg.cacheHome + "/less/history";
      LESSKEY = config.xdg.configHome + "/less/lesskey";
      DELTA_PAGER = "less -R";
      EDITOR = "nvim";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT = "-c";
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
