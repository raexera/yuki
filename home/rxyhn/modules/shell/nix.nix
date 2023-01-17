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

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
