{inputs, ...}: {
  nixpkgs = {
    config.allowUnfree = true;

    overlays = [
      inputs.nix-vscode-extensions.overlays.default
      inputs.nixpkgs-wayland.overlay
    ];
  };
}
