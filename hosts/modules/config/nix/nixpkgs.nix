{inputs, ...}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
    };

    overlays = [
      inputs.nix-vscode-extensions.overlays.default
      inputs.rust-overlay.overlays.default
    ];
  };
}
