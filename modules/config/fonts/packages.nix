{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = false;

    packages = with pkgs; [
      # System Fonts
      corefonts
      vistafonts
      dm-sans
      open-sans
      work-sans
      roboto
      noto-fonts
      noto-fonts-cjk-sans
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
