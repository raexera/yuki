{config, ...}: {
  programs.direnv = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable;
    nix-direnv.enable = true;
  };
}
