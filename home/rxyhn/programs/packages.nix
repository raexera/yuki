{pkgs, ...}: {
  home.packages = with pkgs; [
    discord
    gimp
    keepassxc
    tdesktop
    obsidian
  ];
}
