{pkgs, ...}: {
  home.packages = with pkgs; [
    imv
    mpc_cli
    fortune
    maim
    redshift
    tdesktop
    xclip
    xdotool
    xsel
  ];
}
