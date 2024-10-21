{
  imports = [
    ./bash.nix
    ./gnupg.nix
    ./home-manager.nix
    ./npm.nix
    ./thunar.nix
    ./java.nix
    ./zsh.nix
  ];

  programs = {
    dconf.enable = true;
    kdeconnect.enable = true;
    xfconf.enable = true;
  };
}
