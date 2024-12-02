{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      corefonts
      geist-font
      nerd-fonts.geist-mono
      noto-fonts
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      vistafonts
    ];
  };
}
