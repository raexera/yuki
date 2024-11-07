{
  inputs,
  lib,
  ...
}: {
  nixpkgs = {
    config.allowUnfree = true;

    overlays = [
      inputs.catppuccin-vsc.overlays.default
      inputs.nix-vscode-extensions.overlays.default
      inputs.nixpkgs-wayland.overlay
    ];

    hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
