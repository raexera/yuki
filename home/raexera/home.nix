{
  home = {
    username = "raexera";
    homeDirectory = "/home/raexera";
    stateVersion = "25.05";
    extraOutputsToInstall = ["doc" "devdoc"];
  };

  manual = {
    manpages.enable = false;
    html.enable = false;
    json.enable = false;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
