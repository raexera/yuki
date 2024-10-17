{
  pkgs,
  themes,
  ...
}: {
  console = {
    colors = let
      inherit (themes.colorscheme.colors) normal bright;
    in [
      normal.black # color 0
      normal.red # color 1
      normal.green # color 2
      normal.yellow # color 3
      normal.blue # color 4
      normal.magenta # color 5
      normal.cyan # color 6
      normal.white # color 7
      bright.black # color 8
      bright.red # color 9
      bright.green # color 10
      bright.yellow # color 11
      bright.blue # color 12
      bright.magenta # color 13
      bright.cyan # color 14
      bright.white # color 15
    ];
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v32n.psf.gz";
  };
}
