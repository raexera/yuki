{config, ...}: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable;
  };
}
