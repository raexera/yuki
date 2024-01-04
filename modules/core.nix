{
  pkgs,
  lib,
  ...
}: {
  documentation.dev.enable = true;
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

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
    ];
  };

  programs = {
    less.enable = true;
    ssh.startAgent = true;

    java = {
      enable = true;
      package = pkgs.jre;
    };

    bash.promptInit = ''eval "$(${pkgs.starship}/bin/starship init bash)"'';

    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting = {
        enable = true;
        styles = {"alias" = "fg=magenta";};
        highlighters = ["main" "brackets" "pattern"];
      };
    };
  };

  services.openssh.enable = true;

  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = lib.mkDefault "23.11";

  time = {
    timeZone = lib.mkDefault "Asia/Jakarta";
    hardwareClockInLocalTime = lib.mkDefault true;
  };

  users.users.rxyhn = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "adbusers"
      "docker"
      "input"
      "libvirtd"
      "networkmanager"
      "plugdev"
      "video"
      "wheel"
    ];
  };
}
