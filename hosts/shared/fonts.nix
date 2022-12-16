{
  pkgs,
  lib,
  ...
}: {
  fonts = {
    fonts = lib.attrValues {
      inherit
        (pkgs)
        emacs-all-the-icons-fonts
        inter
        material-icons
        material-design-icons
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        sf-mono-liga
        twemoji-color-font
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
