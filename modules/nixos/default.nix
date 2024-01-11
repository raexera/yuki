{
  flake.nixosModules = {
    system = import ./system;
    intel = import ./hardware/intel.nix;
    nvidia = import ./hardware/nvidia.nix;
    hyprland = import ./system/windowManager/hyprland.nix;
  };
}
