{
  fonts.fontconfig = {
    enable = true;

    antialias = true;

    defaultFonts = {
      serif = ["Noto Serif"];
      sansSerif = ["Geist"];
      monospace = ["GeistMono Nerd Font"];
      emoji = ["Noto Color Emoji"];
    };

    hinting = {
      enable = true;
      autohint = false;
      style = "full";
    };

    subpixel = {
      lcdfilter = "default";
      rgba = "rgb";
    };
  };
}
