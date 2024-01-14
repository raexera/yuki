{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = false;

    fontconfig = {
      enable = true;

      defaultFonts = {
        emoji = ["Noto Color Emoji"];
        monospace = [
          "Iosevka Term"
          "Iosevka Term Nerd Font Complete Mono"
          "Iosevka Nerd Font"
          "Noto Color Emoji"
        ];
        serif = ["Noto Serif" "Noto Color Emoji"];
        sansSerif = ["Inter" "Noto Color Emoji"];
      };
    };

    fontDir = {
      enable = true;
      decompressFonts = true;
    };

    packages = with pkgs; [
      iosevka-bin
      material-icons
      material-design-icons
      monaspace
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      roboto

      (google-fonts.override {fonts = ["Inter"];})
      (nerdfonts.override {fonts = ["Iosevka"];})
    ];
  };
}
