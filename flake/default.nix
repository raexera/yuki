{
  systems = ["x86_64-linux"];

  imports = [
    ../hosts
    ../lib
    ../pkgs
    ./pre-commit-hooks.nix
  ];

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
