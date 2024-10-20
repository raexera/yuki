{pkgs, ...}: {
  imports = [
    ./gnome-keyring.nix
    ./location.nix
    ./networking.nix
    ./openssh.nix
    ./pipewire.nix
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

    udev.packages = with pkgs; [gnome-settings-daemon android-udev-rules];
  };
}
