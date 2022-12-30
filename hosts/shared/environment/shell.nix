{pkgs, ...}: {
  environment = {
    binsh = "${pkgs.bash}/bin/bash";
    shells = with pkgs; [zsh];

    loginShellInit = ''
      dbus-update-activation-environment --all
      eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
      eval $(ssh-agent)
    '';
  };
}
