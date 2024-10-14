{inputs, ...}: {
  nixpkgs = {
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      "electron-25.9.0"
      "freeimage-unstable-2021-11-01"
    ];

    overlays = [
      inputs.nix-vscode-extensions.overlays.default
      inputs.nixpkgs-wayland.overlay
      inputs.nur.overlay
    ];
  };
}
