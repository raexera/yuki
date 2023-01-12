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
        lightdm = {
          enable = true;
          greeters.gtk.cursorTheme = {
            name = "macOS-Monterey";
            package = pkgs.macos-cursors;
            size = 48;
          };
        };
      };

      dpi = 192;
      exportConfiguration = true;
      layout = "${cfg.layout}";

      libinput = {
        enable = true;
        touchpad = {
          disableWhileTyping = true;
          naturalScrolling = true;
        };
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

    qt = {
      enable = true;
      style = "adwaita";
      platformTheme = "gnome";
    };
  };
}
