{
  pkgs,
  config,
  ...
}: {
  boot = {
    tmp.cleanOnBoot = true;
    bootspec.enable = true;
    plymouth.enable = true;
    consoleLogLevel = 3;

    initrd = {
      systemd.enable = true;
      supportedFilesystems = ["ext4"];
    };

    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = [
      "quiet"
      "splash"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
    ];

    loader = {
      timeout = 0; # Spam space to enter the boot menu
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        configurationLimit = 5;
        editor = false;
      };
    };
  };

  environment.systemPackages = [config.boot.kernelPackages.cpupower];
}
