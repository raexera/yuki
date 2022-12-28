# This file (and the global directory) holds config that i use on all hosts
{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./fonts.nix
    ./locale.nix
    ./network.nix
    ./nix.nix
    ./ssh.nix
    ./users.nix
  ];

  console = let
    normal = ["1c252c" "e05f65" "78dba9" "f1cf8a" "70a5eb" "c68aee" "74bee9" "dee1e6"];
    bright = ["384148" "fc7b81" "94f7c5" "ffeba6" "8cc1ff" "e2a6ff" "90daff" "fafdff"];
  in {
    colors = normal ++ bright;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    keyMap = "us";
  };

  environment = {
    binsh = "${pkgs.bash}/bin/bash";
    shells = with pkgs; [zsh];

    systemPackages = with pkgs; [
      curl
      gcc
      git
      hddtemp
      jq
      lm_sensors
      lz4
      ntfs3g
      nvme-cli
      p7zip
      pciutils
      unrar
      unzip
      wget
      zip
    ];

    loginShellInit = ''
      dbus-update-activation-environment --all
      eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
      eval $(ssh-agent)
    '';

    variables = {
      EDITOR = "hx";
      BROWSER = "firefox";
    };
  };

  programs = {
    bash.promptInit = ''eval "$(${pkgs.starship}/bin/starship init bash)"'';

    adb.enable = true;
    dconf.enable = true;
    nm-applet.enable = true;
    seahorse.enable = true;

    npm = {
      enable = true;
      npmrc = ''
        prefix = ''${HOME}/.npm
        color = true
      '';
    };

    java = {
      enable = true;
      package = pkgs.jre;
    };
  };

  services = {
    blueman.enable = true;
    fwupd.enable = true;
    gvfs.enable = true;
    lorri.enable = true;
    udisks2.enable = true;
    printing.enable = true;
    fstrim.enable = true;

    udev.packages = with pkgs; [gnome.gnome-settings-daemon];

    dbus = {
      enable = true;
      packages = with pkgs; [dconf gcr];
    };

    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };

    pipewire = {
      enable = true;
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };

    logind = {
      lidSwitch = "suspend-then-hibernate";
      lidSwitchExternalPower = "lock";
      extraConfig = ''
        HandlePowerKey=suspend-then-hibernate
        HibernateDelaySec=3600
      '';
    };
  };

  systemd.user.services = {
    pipewire.wantedBy = ["default.target"];
    pipewire-pulse.wantedBy = ["default.target"];
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;

    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [pkgs.apparmor-profiles];
    };

    pam = {
      loginLimits = [
        {
          domain = "@wheel";
          item = "nofile";
          type = "soft";
          value = "524288";
        }
        {
          domain = "@wheel";
          item = "nofile";
          type = "hard";
          value = "1048576";
        }
      ];
    };
  };
}
