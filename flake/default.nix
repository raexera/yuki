{
  imports = [
    ./pre-commit-hooks.nix

    ../home/rxyhn
    ../hosts
    ../lib
    ../modules
    ../pkgs
  ];

  systems = ["x86_64-linux"];

  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      DIRENV_LOG_FORMAT = "";

      name = "yuki";

      packages = with pkgs; [
        alejandra
        deadnix
        git
        nil
        statix
      ];

      shellHook = ''
        ${config.pre-commit.installationScript}
      '';
    };

    formatter = pkgs.alejandra;
  };
}
