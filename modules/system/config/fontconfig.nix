{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = false;

    fontconfig = {
      enable = true;

      antialias = true;

      defaultFonts = {
        emoji = ["Noto Color Emoji"];
        monospace = ["Fira Code" "Noto Color Emoji" "Symbols Nerd Font"];
        serif = ["Noto Serif" "Noto Color Emoji"];
        sansSerif = ["Inter" "Noto Color Emoji"];
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
      material-design-icons
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji

      (google-fonts.override {fonts = ["Inter"];})
      (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    ];
  };
}
