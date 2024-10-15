{
  config,
  lib,
  ...
}: {
  services.greetd = let
    session = {
      command = "${lib.getExe config.programs.hyprland.package}";
      user = "raexera";
    };
  in {
    enable = true;
    settings = {
      terminal.vt = 1;
      default_session = session;
      initial_session = session;
    };
  };

  # Unlock GPG keyring on login
  security.pam.services.greetd.enableGnomeKeyring = true;
}
