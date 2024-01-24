{
  imports = [
    ./extensions.nix
    ./settings.nix
  ];

  programs.vscode.enable = true;
  xdg.mimeApps.defaultApplications."text/plain" = "code.desktop";
}
