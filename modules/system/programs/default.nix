{
  lib,
  pkgs,
  ...
}: {
  programs = {
    bash.promptInit = ''eval "$(${lib.getExe pkgs.starship} init bash)"'';

    java = {
      enable = true;
      package = pkgs.jre;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      promptInit = ''
        eval "$(${lib.getExe pkgs.starship} init zsh)"
      '';
    };

    dconf.enable = true;
    kdeconnect.enable = true;
    seahorse.enable = true;
    nm-applet.enable = true;
  };
}
