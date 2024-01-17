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
    greetd = import ./services/display-managers/greetd.nix;
    hyprland = import ./services/wayland/window-managers/hyprland.nix;
    intel = import ./hardware/intel.nix;
    nvidia = import ./hardware/nvidia.nix;
  };
}
