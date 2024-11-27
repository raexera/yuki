{config, ...}: {
  programs.direnv = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable;
    nix-direnv.enable = true;
  };

  home.sessionVariables.DIRENV_LOG_FORMAT = "";
}
