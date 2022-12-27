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
    ranger
    ripgrep
    yt-dlp
  ];

  programs = {
    bat.enable = true;
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
