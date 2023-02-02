{
  pkgs,
  lib,
  ...
}: {
  fonts = {
    fonts = lib.attrValues {
      inherit
        (pkgs)
        inter
        material-symbols
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        sf-mono-liga
        ;
    };

    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        autohint = true;
        style = "hintfull";
      };

      subpixel.lcdfilter = "default";

      defaultFonts = {
        emoji = ["Noto Color Emoji"];
        monospace = ["Liga SFMono Nerd Font"];
        sansSerif = ["Noto Sans" "Noto Color Emoji"];
        serif = ["Noto Serif" "Noto Color Emoji"];
      };
    };
  };
}
