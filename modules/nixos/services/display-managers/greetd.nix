{
  config,
  lib,
  pkgs,
  ...
}: {
  security = {
    pam.services = {
      greetd = {
        gnupg.enable = true;
        enableGnomeKeyring = true;
      };
    };
  };

  services = {
    greetd = {
      enable = true;
      settings = {
        terminal.vt = 1;
        default_session = let
          base = config.services.xserver.displayManager.sessionData.desktops;
        in {
          command = lib.concatStringsSep " " [
            (lib.getExe pkgs.greetd.tuigreet)
            "--time"
            "--remember"
            "--remember-user-session"
            "--asterisks"
            "--sessions '${base}/share/wayland-sessions:${base}/share/xsessions'"
          ];
          user = "greeter";
        };
      };
    };
  };
}
