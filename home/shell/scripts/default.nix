{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [./run-as-service.nix];
  home = {
    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
    ];

    file = {
      ".local/bin/extract" = {
        executable = true;
        text = import ./extract.nix {inherit lib pkgs;};
      };

      ".local/bin/preview" = {
        executable = true;
        text = import ./preview.nix {inherit lib pkgs;};
      };

      ".local/bin/updoot" = {
        executable = true;
        text = import ./updoot.nix {inherit lib pkgs;};
      };
    };
  };
}
