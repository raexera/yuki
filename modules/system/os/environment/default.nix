{pkgs, ...}: {
  imports = [
    ./locale.nix
  ];

  environment = {
    loginShellInit = "dbus-update-activation-environment --systemd DISPLAY";
    pathsToLink = ["/share/zsh"];

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
