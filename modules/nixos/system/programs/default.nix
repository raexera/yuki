{
  imports = [
    ./bash.nix
    ./fonts.nix
    ./home-manager.nix
    ./java.nix
    ./zsh.nix
  ];

  programs = {
    dconf.enable = true;
    kdeconnect.enable = true;
    nm-applet.enable = true;
    seahorse.enable = true;
    xfconf.enable = true;
  };
}
