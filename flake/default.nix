{
  imports = [
    ../home
    ../hosts
    ../lib
    ../pkgs
    ./pre-commit-hooks.nix
  ];

  systems = ["x86_64-linux"];

  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShell {
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
