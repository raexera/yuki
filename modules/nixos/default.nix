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
    gdm = import ./services/display-managers/gdm.nix;
    greetd = import ./services/display-managers/greetd.nix;
    hyprland = import ./services/wayland/window-managers/hyprland.nix;
    intel = import ./hardware/intel.nix;
    nvidia = import ./hardware/nvidia.nix;
  };
}
