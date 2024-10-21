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

    fontDir = {
      enable = true;
      decompressFonts = true;
    };

    packages = with pkgs; [
      # System Fonts
      corefonts
      vistafonts
      dm-sans
      open-sans
      work-sans
      roboto
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji

      # Monospace
      jetbrains-mono

      # Icon Fonts
      material-design-icons

      # Custom Fonts
      (google-fonts.override {fonts = ["Inter"];})
      (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    ];
  };
}
