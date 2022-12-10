{
  inputs,
  config,
  ...
}: let
  inherit (inputs.nix-colors) colorSchemes;

  # Custom colorscheme list
  carbon-dark = (import ./carbon-dark.nix).colorscheme;
  oxocarbon-dark = (import ./oxocarbon-dark.nix).colorscheme;
  yoru = (import ./yoru.nix).colorscheme;
  radium = (import ./radium.nix).colorscheme;
in {
  imports = [
    inputs.nix-colors.homeManagerModule
  ];

  # Use the custom color scheme
  colorscheme = oxocarbon-dark;

  # Use the colorscheme available at github:tinted-theming/base16-schemes
  # colorscheme = colorSchemes.catppuccin;
}
