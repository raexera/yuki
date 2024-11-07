{
  pkgs,
  config,
  ...
}: {
  boot = {
    bootspec.enable = true;
    consoleLogLevel = 3;

    initrd = {
      systemd.enable = true;
      supportedFilesystems = ["ext4"];
    };

    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = [
      "quiet"
      "splash"
      "nowatchdog"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
    ];

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        configurationLimit = 5;
        consoleMode = "max";
      };
    };

    plymouth.enable = true;
  };

  environment.systemPackages = [config.boot.kernelPackages.cpupower];
}
