{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.nixos.windowManager.hyprland;
in {
  options.modules.nixos.windowManager.hyprland = {
    enable = mkEnableOption "Enable The Awesome Window Manager";
  };

  config = mkIf cfg.enable {
    services = {
      greetd = {
        enable = true;
        settings = rec {
          initial_session = {
            command = "Hyprland";
            user = "rxyhn";
          };
          default_session = initial_session;
        };
      };

      # add hyprland to display manager sessions
      xserver.displayManager.sessionPackages = [inputs.hyprland.packages.${pkgs.system}.default];
    };

    # selectable options
    environment.etc."greetd/environments".text = ''
      Hyprland
    '';

    # enable hyprland
    programs.hyprland.nvidiaPatches = true;

    security = {
      pam.services.swaylock = {
        text = ''
          auth include login
        '';
      };
    };

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-kde
      ];
    };

    qt5 = {
      enable = true;
      style = "adwaita";
      platformTheme = "gnome";
    };

    # use Wayland where possible (electron)
    environment.variables.NIXOS_OZONE_WL = "1";
  };
}
