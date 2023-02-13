{pkgs, ...}: {
  imports = [
    ./pkgs
    ./variables.nix
  ];

  environment = {
    binsh = "${pkgs.bash}/bin/bash";
    shells = [pkgs.zsh];
    pathsToLink = ["/share/zsh"];

    loginShellInit = ''
      dbus-update-activation-environment --all
      eval $(ssh-agent)
      eval $(gnome-keyring-daemon --start --daemonize --components=pkcs11,secrets,ssh)
    '';
  };
}
