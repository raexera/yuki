{
  pkgs,
  lib,
  ...
}: {
  environment.pathsToLink = ["/share/zsh"];

  environment.loginShellInit = ''
    dbus-update-activation-environment --systemd DISPLAY
    eval $(${pkgs.gnome.gnome-keyring}/bin/gnome-keyring-daemon --start --components=ssh,secrets)
    eval $(${pkgs.openssh}/bin/ssh-agent)
  '';

  environment.systemPackages = with pkgs;
    [
      git
      starship
      vim
      neovim

      (python3.withPackages (p:
        with p; [
          pygobject3
        ]))
    ]
    ++ [
      gobject-introspection
      pipenv
    ];

  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v32n.psf.gz";
  };
}
