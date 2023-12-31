{pkgs, ...}: {
  home.packages = with pkgs; [
    discord
    tdesktop
    libnotify
    xdg-utils
    obsidian
  ];
}
