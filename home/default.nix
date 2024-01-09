{
  home = {
    username = "rxyhn";
    homeDirectory = "/home/rxyhn";
    extraOutputsToInstall = ["doc" "devdoc"];
    stateVersion = "23.11";
  };

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  programs.home-manager.enable = true;
}
