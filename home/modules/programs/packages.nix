{pkgs, ...}: {
  home.packages = with pkgs; [
    tdesktop
    libnotify
    xdg-utils
    obsidian
  ];
}
