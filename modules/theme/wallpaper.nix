{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) types mkOption;
in {
  options.wallpaper = mkOption {
    type = types.path;
    default = "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray}/share/backgrounds/nixos/nix-wallpaper-nineish-dark-gray.png";
    description = ''
      Wallpaper path
    '';
  };
}
