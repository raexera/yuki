{pkgs, ...}: {
  home.packages = with pkgs; [
    imv
    mpc_cli
    discord-canary
    feh
    fortune
    maim
    redshift
    tdesktop
    xclip
    xdotool
    xsel
  ];
}
