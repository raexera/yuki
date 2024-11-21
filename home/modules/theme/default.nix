{lib, ...}: let
  inherit (lib) mkOption;
  inherit (lib.types) attrsOf path str;
in {
  options.theme = {
    colorscheme = mkOption {
      type = attrsOf (attrsOf str);
      description = ''
        The colors used in the theming.
      '';
    };

    wallpaper = mkOption {
      type = path;
      description = ''
        Wallpaper image.
      '';
    };
  };
}
