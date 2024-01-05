{pkgs, ...}: {
  location.provider = "geoclue2";

  environment.loginShellInit = "dbus-update-activation-environment --systemd DISPLAY";

  programs = {
    dconf.enable = true;
    kdeconnect.enable = true;
    seahorse.enable = true;
  };

  services = {
    geoclue2.enable = true;
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
