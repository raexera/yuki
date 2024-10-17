{inputs, ...}: {
  nixpkgs = {
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      "electron-25.9.0"
    ];

    overlays = [
      inputs.nix-vscode-extensions.overlays.default
      inputs.nixpkgs-wayland.overlay
      inputs.nur.overlay
    ];
  };
}
