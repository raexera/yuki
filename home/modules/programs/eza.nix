{config, ...}: {
  programs.eza = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable;
    extraOptions = ["--group-directories-first" "--header"];
    colors = "always";
    icons = "always";
    git = true;
  };
}
