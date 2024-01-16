{
  flake.nixosModules = {
    base = {
      imports = [
        ./config
        ./programs
        ./security
        ./services
      ];
    };

    bluetooth = import ./hardware/bluetooth.nix;
    hyprland = import ./services/wayland/window-managers/hyprland.nix;
    intel = import ./hardware/intel.nix;
    nvidia = import ./hardware/nvidia.nix;
  };
}
