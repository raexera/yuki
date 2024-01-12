{pkgs, ...}: {
  home.packages = with pkgs; [
    discord
    gimp
    keepassxc
    tdesktop
    obsidian
    plasma5Packages.ark
    plasma5Packages.dolphin
    plasma5Packages.dolphin-plugins
    plasma5Packages.kio
    plasma5Packages.kio-extras
    plasma5Packages.kimageformats
    plasma5Packages.kdegraphics-thumbnailers
    plasma5Packages.okular
  ];
}
