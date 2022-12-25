{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.nixos.windowManager.awesome;
in {
  options.modules.nixos.windowManager.awesome = {
    enable = mkEnableOption "Enable The Awesome Window Manager";

    dpi = mkOption {
      type = types.int;
      default = 96;
      description = "The DPI to use for the X server.";
    };

    layout = mkOption {
      type = types.str;
      default = "us";
      description = "The keyboard layout to use for the X server.";
    };
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      displayManager = {
        autoLogin = {
          enable = true;
          user = "rxyhn";
        };

        defaultSession = "none+awesome";
        lightdm.enable = true;
      };

      dpi = cfg.dpi;
      exportConfiguration = true;
      layout = "${cfg.layout}";

      libinput = {
        enable = true;
        touchpad = {naturalScrolling = true;};
      };

      windowManager = {
        awesome = {
          enable = true;
          luaModules = lib.attrValues {
            inherit (pkgs.luaPackages) lgi ldbus luadbi-mysql luaposix;
          };
        };
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
  };
}
