{pkgs, ...}:
# nix tooling
{
  home = {
    packages = with pkgs; [
      alejandra
      any-nix-shell
      deadnix
      nix-index
      statix
    ];

    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
    };
  };

  programs = {
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
