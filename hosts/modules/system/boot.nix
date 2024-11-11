{pkgs, ...}: {
  boot.consoleLogLevel = 3;

  boot.initrd.verbose = false;
  boot.initrd.systemd.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "quiet"
    "splash"
    "loglevel=3"
    "udev.log_level=3"
    "rd.udev.log_level=3"
    "systemd.show_status=auto"
    "rd.systemd.show_status=auto"
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  boot.loader.timeout = 0; # Spam space to enter the boot menu
  boot.loader.systemd-boot = {
    enable = true;
    editor = false;
    configurationLimit = 5;
  };

  boot.plymouth.enable = true;
  boot.plymouth.theme = "bgrt";

  boot.tmp.cleanOnBoot = true;
}
