{
  imports = [./hardware-configuration.nix];

  boot = {
    kernelModules = ["kvm-intel"];

    initrd.kernelModules = ["ideapad_laptop"];

    blacklistedKernelModules = ["nouveau"];

    kernelParams = [
      "mem_sleep_default=deep"
      "pcie_aspm.policy=powersupersave"
    ];

    extraModprobeConfig = ''
      options i915 enable_guc=3
      options i915 enable_psr=0
      options i915 force_probe=46a6
    '';

    initrd.luks.devices = {
      yuki = {
        device = "/dev/disk/by-uuid/dd3b871e-d7ef-40af-a1e3-d63c26c76662";
        preLVM = true;
        allowDiscards = true;
      };
    };
  };

  hardware = {
    enableAllFirmware = true;

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia.prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  services = {
    acpid.enable = true;
    fwupd.enable = true;
    hardware.bolt.enable = true;
    thermald.enable = true;
    tlp.enable = true;

    logind = {
      powerKey = "suspend";
      lidSwitch = "suspend";
      lidSwitchExternalPower = "lock";
    };
  };

  # NVIDIA GeForce RTX 3050 Mobile (Ampere)
  services.xserver.videoDrivers = ["nvidia"];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}
