{
  pkgs,
  themes,
  ...
}: {
  console = {
    colors = let
      inherit (themes.colorscheme) colors;
    in [
      colors.black2
      colors.red
      colors.green
      colors.yellow
      colors.blue
      colors.pink
      colors.teal
      colors.white
      colors.gray1
      colors.red
      colors.green
      colors.yellow
      colors.blue
      colors.pink
      colors.teal
      colors.white
    ];
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v32n.psf.gz";
  };
}
