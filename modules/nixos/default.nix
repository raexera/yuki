{
  flake.nixosModules = {
    bluetooth = import ./hardware/bluetooth.nix;
    hyprland = import ./system/windowManager/hyprland.nix;
    intel = import ./hardware/intel.nix;
    nvidia = import ./hardware/nvidia.nix;
    system = import ./system;
  };
}
