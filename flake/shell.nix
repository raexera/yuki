{
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      name = "yuki";

      shellHook = ''
        ${config.pre-commit.installationScript}
      '';

      packages = with pkgs; [
        alejandra
        deadnix
        git
        nil
        statix
      ];
    };

    formatter = pkgs.alejandra;
  };
}
