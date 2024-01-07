{lib, ...}: let
  inherit (lib) types mkOption;
in {
  options.colorscheme = mkOption {
    type = types.submodule {
      options.colors = mkOption {
        type = types.attrsOf types.str;
        default = {};
        description = "Base16 representation of the theme";
      };
    };
    default = {};
    description = ''
      Base16 colorscheme
    '';
  };
}
