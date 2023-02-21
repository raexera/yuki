{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./pipewire.nix
  ];

  services = {
    blueman.enable = true;
    udisks2.enable = true;

    dbus = {
      enable = true;
      packages = with pkgs; [dconf gcr];
    };

    fstrim.enable = true;
    fwupd.enable = true;
    geoclue2.enable = true;

    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };

    gvfs.enable = true;

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = lib.mkForce false;
        PermitRootLogin = lib.mkForce "no";
      };
    };

    udev.packages = [pkgs.gnome.gnome-settings-daemon];
  };

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
    };

    libvirtd.enable = true;
  };
}
