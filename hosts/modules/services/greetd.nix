{
  config,
  lib,
  pkgs,
  ...
}: {
  services.greetd = {
    enable = true;
    settings = {
      terminal.vt = 1;
      default_session = {
        command = lib.concatStringsSep " " [
          (lib.getExe pkgs.greetd.tuigreet)
          "--cmd '${lib.getExe config.programs.hyprland.package}'"
          "--remember"
          "--remember-session"
          "--asterisks"
          "--time"
        ];
        user = "greeter";
      };
    };
  };

  # Unlock GPG keyring on login
  security.pam.services.greetd.enableGnomeKeyring = true;
}
