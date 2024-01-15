{pkgs, ...}: {
  imports = [
    ./pipewire.nix
  ];

  location.provider = "geoclue2";

  services = {
    accounts-daemon.enable = true;
    devmon.enable = true;
    geoclue2.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;

    dbus = {
      enable = true;
      packages = with pkgs; [dconf gcr udisks2];
    };

    udev.packages = with pkgs; [gnome.gnome-settings-daemon android-udev-rules];
  };
}
