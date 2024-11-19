{config, ...}: {
  programs.fzf = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable;
  };
}
