{pkgs, ...}: {
  imports = [
    ./greetd.nix
  ];

  location.provider = "geoclue2";

  services = {
    geoclue2.enable = true;
    gnome.glib-networking.enable = true;
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
    power-profiles-daemon.enable = true;

    psd = {
      enable = true;
      resyncTimer = "10m";
    };

    dbus = {
      enable = true;
      packages = with pkgs; [dconf gcr udisks2];
    };

    udev.packages = with pkgs; [gnome.gnome-settings-daemon android-udev-rules];
  };
}
