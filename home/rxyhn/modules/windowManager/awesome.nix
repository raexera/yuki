{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./gtk.nix
    ./picom.nix
  ];

  xresources.extraConfig = ''
    Xft.dpi: 144
    Xft.antialias: true
    Xft.hinting: true
    Xft.rgba: rgb
    Xft.autohint: false
    Xft.hintstyle: hintfull
    Xft.lcdfilter: lcddefault

    Xcursor.size: 48

    *background: #1E1E2E
    *foreground: #CDD6F4

    ! black
    *color0: #45475A
    *color8: #585B70

    ! red
    *color1: #F38BA8
    *color9: #F38BA8

    ! green
    *color2: #A6E3A1
    *color10: #A6E3A1

    ! yellow
    *color3: #F9E2AF
    *color11: #F9E2AF

    ! blue
    *color4: #89B4FA
    *color12: #89B4FA

    ! magenta
    *color5: #F5C2E7
    *color13: #F5C2E7

    ! cyan
    *color6: #94E2D5
    *color14: #94E2D5

    ! white
    *color7: #BAC2DE
    *color15: #A6ADC8
  '';

  home = {
    packages = with pkgs; [
      feh
      fortune
      gcalcli
      gnome.dconf-editor
      libcanberra-gtk3
      libgudev
      maim
      mpg123
      redshift
      taskwarrior
      timewarrior
      xclip
    ];
  };
}
