{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs;
      [
        git
        starship
        vim
        neovim

        (python3.withPackages (p:
          with p; [
            pygobject3
          ]))
      ]
      ++ [
        gobject-introspection
        pipenv
      ];
  };
}
