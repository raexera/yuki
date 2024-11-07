{
  imports = [./hardware-configuration.nix];

  boot.initrd.kernelModules = ["ideapad_laptop"];
  boot.kernelModules = ["kvm-intel"];
  boot.kernelParams = ["i915.force_probe=46a6"];
  boot.blacklistedKernelModules = ["nouveau"];

  boot.initrd.luks.devices = {
    yuki = {
      device = "/dev/disk/by-uuid/dd3b871e-d7ef-40af-a1e3-d63c26c76662";
      preLVM = true;
      allowDiscards = true;
    };
  };

  hardware.enableAllFirmware = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  services = {
    acpid.enable = true;
    fwupd.enable = true;
    hardware.bolt.enable = true;
    thermald.enable = true;

    tlp = {
      enable = true;
      settings = {
        START_CHARGE_THRESH_BAT0 = 0;
        STOP_CHARGE_THRESH_BAT0 = 1;
      };
    };

    logind = {
      powerKey = "suspend";
      lidSwitch = "suspend";
      lidSwitchExternalPower = "lock";
    };
  };

  # NVIDIA GeForce RTX 3050 Mobile (Ampere)
  services.xserver.videoDrivers = ["nvidia"];
}
