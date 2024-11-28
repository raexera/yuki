{config, ...}: {
  programs.dircolors = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable;
  };
}
