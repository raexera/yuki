{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = false;

    packages = with pkgs; [
      corefonts
      geist-font
      nerd-fonts.geist-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      vistafonts
    ];
  };
}
