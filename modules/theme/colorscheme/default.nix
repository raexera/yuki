# merge colors lib and defined colorsheme here
{lib, ...}: let
  inherit (lib) types mkOption;
in {
  options.colorscheme = mkOption {
    type = types.attrsOf types.any;
    default = {};
    description = ''
      Base16 colorscheme
    '';
  };
}
