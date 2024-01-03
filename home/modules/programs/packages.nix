{pkgs, ...}: {
  home.packages = with pkgs; [
    discord
    tdesktop
    obsidian
  ];
}
