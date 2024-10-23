{
  pkgs,
  themes,
  ...
}: {
  console = {
    colors = let
      inherit (themes.colorscheme) colors;
    in [
      colors.normal.black # color 0
      colors.normal.red # color 1
      colors.normal.green # color 2
      colors.normal.yellow # color 3
      colors.normal.blue # color 4
      colors.normal.magenta # color 5
      colors.normal.cyan # color 6
      colors.normal.white # color 7
      colors.bright.black # color 8
      colors.bright.red # color 9
      colors.bright.green # color 10
      colors.bright.yellow # color 11
      colors.bright.blue # color 12
      colors.bright.magenta # color 13
      colors.bright.cyan # color 14
      colors.bright.white # color 15
    ];
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v32n.psf.gz";
  };
}
