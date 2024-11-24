{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  environment = {
    shells = [pkgs.zsh];
    pathsToLink = ["/share/zsh"];
  };

  users.defaultUserShell = pkgs.zsh;
}
