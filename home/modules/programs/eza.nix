{config, ...}: {
  programs.eza = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable;
    icons = "always";
    git = true;
  };
}
