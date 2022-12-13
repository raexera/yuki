{
  inputs,
  config,
  ...
}: let
  inherit (inputs.nix-colors) colorSchemes;

  # Custom colorscheme list
  carbon-dark = (import ./carbon-dark.nix).colorscheme;
  default-dark = (import ./default-dark.nix).colorscheme;
  oxocarbon-dark = (import ./oxocarbon-dark.nix).colorscheme;
in {
  imports = [
    inputs.nix-colors.homeManagerModule
  ];

  # Use the custom color scheme
  # colorscheme = default-dark;

  # Use the colorscheme available at github:tinted-theming/base16-schemes
  colorscheme = colorSchemes.ashes;
}
