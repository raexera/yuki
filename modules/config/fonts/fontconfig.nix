{
  fonts.fontconfig = {
    enable = true;

    antialias = true;

    defaultFonts = let
      addAll = builtins.mapAttrs (_: v: ["Symbols Nerd Font"] ++ v ++ ["Noto Color Emoji"]);
    in
      addAll {
        serif = ["Noto Serif"];
        sansSerif = ["Inter"];
        monospace = ["JetBrains Mono"];
        emoji = [];
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
