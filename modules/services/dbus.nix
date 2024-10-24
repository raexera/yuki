{pkgs, ...}: {
  services = {
    dbus = {
      enable = true;
      implementation = "broker";

      packages = with pkgs; [
        gcr
        gnome-settings-daemon
      ];
    };

    gvfs.enable = true;

    psd = {
      enable = true;
      resyncTimer = "10m";
    };

    power-profiles-daemon.enable = true;

    tumbler.enable = true;
  };
}
