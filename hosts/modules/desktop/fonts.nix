{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      material-icons
      material-design-icons
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      roboto

      (google-fonts.override {fonts = ["Dosis" "Inter"];})
      (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
    ];

    enableDefaultPackages = false;

    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Noto Color Emoji"];
      sansSerif = ["Dosis" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };
}
