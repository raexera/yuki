{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    file
    du-dust
    duf
    fd
    ripgrep

    joshuto
    ranger
  ];

  programs = {
    exa.enable = true;

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
