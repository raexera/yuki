{pkgs, ...}: {
  imports = [
    ./networking.nix
    ./pipewire.nix
    ./ssh.nix
  ];

  services = {
    accounts-daemon.enable = true;
    devmon.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
    tumbler.enable = true;

    dbus = {
      enable = true;
      implementation = "broker";
      packages = with pkgs; [dconf gcr udisks2];
    };

    udev.packages = with pkgs; [gnome.gnome-settings-daemon android-udev-rules];
  };
}
