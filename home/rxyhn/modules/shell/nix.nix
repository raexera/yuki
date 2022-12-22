{
  pkgs,
  inputs,
  ...
}:
# nix tooling
{
  home = {
    packages = with pkgs; [
      alejandra
      deadnix
      nix-index
      statix
    ];

    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
}
