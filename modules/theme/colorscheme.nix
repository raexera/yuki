{lib, ...}: let
  inherit (lib) types mkOption;
in {
  options.colorscheme = mkOption {
    type = types.submodule {
      options = {
        author = mkOption {
          type = types.str;
          default = "";
          description = "Author of the theme";
        };

        name = mkOption {
          type = types.str;
          default = "";
          description = "Name of the theme";
        };

        colors = mkOption {
          type = types.attrsOf types.str;
          default = {};
          description = "Base16 representation of the theme";
        };
      };
    };
    default = {};
    description = ''
      Base16 colorscheme
    '';
  };
}
