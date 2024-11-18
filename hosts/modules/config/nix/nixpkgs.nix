{
  inputs,
  lib,
  ...
}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
    };

    hostPlatform = lib.mkDefault "x86_64-linux";

    overlays = [
      inputs.catppuccin-vsc.overlays.default
      inputs.nix-vscode-extensions.overlays.default
      inputs.nixpkgs-wayland.overlay
      inputs.rust-overlay.overlays.default
    ];
  };
}
