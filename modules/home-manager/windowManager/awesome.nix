{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.hm.windowManager.awesome;
in {
  imports = [
    ./gtk.nix
    ./picom.nix
  ];

  options.modules.hm.windowManager.awesome = {
    enable = mkEnableOption "Configure Awesome WM";

    dpi = mkOption {
      type = types.int;
      default = 96;
      description = "The DPI to use for the window manager.";
    };
  };

  config = mkIf cfg.enable {
    xresources.extraConfig = ''
      Xft.dpi: ${toString cfg.dpi}
      Xft.antialias: true
      Xft.hinting: true
      Xft.rgba: rgb
      Xft.autohint: false
      Xft.hintstyle: hintfull
      Xft.lcdfilter: lcddefault

      Xcursor.size: 48

      *foreground: #b6beca
      *background: #101419
      *.cursorColor:  #b6beca

      ! black
      *color0: #242931
      *color8: #485263

      ! red
      *color1: #e05f65
      *color9: #e05f65

      ! green
      *color2: #78dba9
      *color10: #78dba9

      ! yellow
      *color3: #f1cf8a
      *color11: #f1cf8a

      ! blue
      *color4: #70a5eb
      *color12: #70a5eb

      ! magenta
      *color5: #c68aee
      *color13: #c68aee

      ! cyan
      *color6: #74bee9
      *color14: #74bee9

      ! white
      *color7: #dee1e6
      *color15: #dee1e6
    '';

    modules.hm.windowManager = {
      gtk.enable = true;
      services = {
        picom = {
          enable = true;
          shadow = true;
          shadowOffsets = [(-40) (-20)];
          cornerRadius = 22;
          blurStrength = 10;
        };
      };
    };

    home = {
      sessionVariables = {
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      };
    };
  };
}
