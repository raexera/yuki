{pkgs, ...}: {
  imports = [
    ./extensions.nix
    ./keybindings.nix
    ./settings.nix
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
  };
}
