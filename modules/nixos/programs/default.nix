{
  imports = [
    ./bash.nix
    ./home-manager.nix
    ./zsh.nix
  ];

  programs = {
    dconf.enable = true;
    kdeconnect.enable = true;
    seahorse.enable = true;
    xfconf.enable = true;
  };
}
