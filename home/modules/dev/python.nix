{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      (python3.withPackages (ps:
        with ps; [
          pip
          pygobject3
        ]))

      gobject-introspection
      pipenv
      ruff
      ruff-lsp
    ];
  };
}
