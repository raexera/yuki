{
  fonts.fontconfig = {
    enable = true;

    antialias = true;

    hinting = {
      enable = true;
      autohint = false;
      style = "full";
    };

    subpixel = {
      lcdfilter = "default";
      rgba = "rgb";
    };

    defaultFonts = {
      monospace = ["GeistMono Nerd Font"];
      sansSerif = ["Geist" "Noto Color Emoji"];
      serif = ["Noto Serif" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };
}
