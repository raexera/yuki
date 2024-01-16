{inputs, ...}: {
  nixpkgs = {
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      "electron-25.9.0"
    ];

    overlays = [
      inputs.nur.overlay
      inputs.nix-vscode-extensions.overlays.default
      inputs.catppuccin-vsc.overlays.default
    ];
  };
}
