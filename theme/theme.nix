inputs:
with inputs.self.lib; rec {
  colors = import ./catppuccin.nix {};
  # #RRGGBB
  xcolors = mapAttrs (_: x) colors;
  # #RRGGBBAA
  xrgbaColors = mapAttrs (_: xrgba) colors;
  # #AARRGGBB
  xargbColors = mapAttrs (_: xargb) colors;
  # rgba(,,,) colors (css)
  rgbaColors = mapAttrs (_: rgba) colors;
}
