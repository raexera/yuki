{inputs, ...}: {
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay

    ./pre-commit-hooks.nix
    ./modules
    ../home
    ../hosts
    ../lib
    ../pkgs
  ];

  systems = ["x86_64-linux"];

  perSystem = {
    config,
    pkgs,
    ...
  }: {
    imports = [{_module.args.pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;}];

    formatter = pkgs.alejandra;

    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        alejandra
        deadnix
        git
        nil
      ];

      name = "yuki";
      meta.description = "The default development shell";

      DIRENV_LOG_FORMAT = "";
      shellHook = ''
        ${config.pre-commit.installationScript}
      '';
    };
  };
}
