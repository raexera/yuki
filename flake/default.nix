{
  imports = [
    ./pre-commit-hooks.nix
    ./treefmt.nix

    ../home/rxyhn
    ../hosts
    ../lib
    ../modules
    ../pkgs
  ];

  systems = [
    "x86_64-linux"
    "aarch64-linux"
  ];

  perSystem = {
    config,
    pkgs,
    ...
  }: {
    formatter = pkgs.alejandra;

    devShells.default = pkgs.mkShell {
      name = "yuki";

      shellHook = ''
        ${config.pre-commit.installationScript}
      '';

      DIRENV_LOG_FORMAT = "";

      packages = with pkgs; [
        config.treefmt.build.wrapper

        alejandra
        deadnix
        git
        glow
        nil
        nodejs
        statix
      ];

      inputsFrom = [config.treefmt.build.devShell];
    };
  };
}
