{
  config,
  pkgs,
  self,
  ...
}: {
  imports = [./hardware-configuration.nix];

  # kernel
  boot = {
    extraModulePackages = with config.boot.kernelPackages; [acpi_call];
    kernelModules = ["acpi_call"];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "i8042.direct"
      "i8042.dumbkbd"
      "i915.enable_psr=0"
      "iommu=pt"
      "module_blacklist=nouveau"
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];
  };

  hardware = {
    enableAllFirmware = true;
    opengl = {
      extraPackages = with pkgs; [
        vaapiIntel
        libvdpau-va-gl
        vaapiVdpau
        intel-ocl
      ];

      extraPackages32 = with pkgs.pkgsi686Linux; [
        vaapiIntel
        libvdpau-va-gl
        vaapiVdpau
      ];
    };

    nvidia = {
      modesetting.enable = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  networking.hostName = "yuki";

  programs = {
    hyprland.enable = true;
  };

  services = {
    xserver.videoDrivers = ["nvidia"];
  };
}
