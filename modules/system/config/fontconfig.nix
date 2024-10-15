{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = false;

    fontconfig = {
      enable = true;

      antialias = true;

      defaultFonts = let
        addAll = builtins.mapAttrs (_: v: ["Symbols Nerd Font"] ++ v ++ ["Noto Color Emoji"]);
      in
        addAll {
          serif = ["Noto Serif"];
          sansSerif = ["Inter"];
          monospace = ["Fira Code"];
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

    fontDir = {
      enable = true;
      decompressFonts = true;
    };

    packages = with pkgs; [
      fira-code
      fira-code-symbols
      jetbrains-mono
      material-design-icons
      material-symbols
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      roboto
      (google-fonts.override {fonts = ["Inter"];})
      (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    ];
  };
}
