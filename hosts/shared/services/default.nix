{pkgs, ...}: {
  imports = [
    ./pipewire.nix
  ];

  services = {
    dbus = {
      enable = true;
      packages = with pkgs; [dconf gcr];
    };

    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };

    logind = {
      lidSwitch = "suspend-then-hibernate";
      lidSwitchExternalPower = "lock";
      extraConfig = ''
        HandlePowerKey=suspend-then-hibernate
        HibernateDelaySec=3600
      '';
    };

    udev.packages = [pkgs.gnome.gnome-settings-daemon];

    blueman.enable = true;
    fstrim.enable = true;
    fwupd.enable = true;
    geoclue2.enable = true;
    gvfs.enable = true;
    openssh.enable = true;
    printing.enable = true;
    udisks2.enable = true;
    upower.enable = true;
  };

  virtualisation = {
    libvirtd.enable = true;
    docker = {
      enable = true;
      enableOnBoot = false;
    };
  };
}
