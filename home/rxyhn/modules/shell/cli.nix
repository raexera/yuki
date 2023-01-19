{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    catimg
    duf
    du-dust
    fd
    file
    joshuto
    perl
    ranger
    ripgrep
    yt-dlp
  ];

  programs = {
    bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "Catppuccin-mocha";
      };
      themes = {
        Catppuccin-mocha = builtins.readFile (pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "00bd462e8fab5f74490335dcf881ebe7784d23fa";
            sha256 = "yzn+1IXxQaKcCK7fBdjtVohns0kbN+gcqbWVE4Bx7G8=";
          }
          + "/Catppuccin-mocha.tmTheme");
      };
    };

    exa.enable = true;

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
