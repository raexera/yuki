{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./starship.nix
    ./transient-services.nix
    ./zsh.nix
    ../programs/git.nix
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
}
