{
  lib,
  pkgs,
  ...
}: {
  environment.pathsToLink = ["/share/zsh"];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    promptInit = ''
      eval "$(${lib.getExe pkgs.starship} init zsh)"
    '';
  };
}
