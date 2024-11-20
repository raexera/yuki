{inputs, ...}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
    };

    overlays = [
      inputs.catppuccin-vsc.overlays.default
      inputs.nix-vscode-extensions.overlays.default
      inputs.nixpkgs-wayland.overlay
      inputs.rust-overlay.overlays.default
    ];
  };
}
