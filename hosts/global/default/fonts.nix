{
  lib,
  pkgs,
  ...
}: {
  fonts = {
    fonts = lib.attrValues {
      inherit
        (pkgs)
        cantarell-fonts
        fira
        lato
        maple-mono
        maple-mono-NF
        maple-mono-SC-NF
        material-symbols
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        roboto-slab
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
        monospace = ["Maple Mono NF"];
        sansSerif = ["Lato"];
        serif = ["Roboto Slab"];
      };
    };
  };
}
