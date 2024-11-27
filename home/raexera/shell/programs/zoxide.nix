{config, ...}: {
  programs.zoxide = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable;
    options = [
      "--cmd cd"
    ];
  };
}
