{
  imports = [
    ./modules/shell
    ./modules/programs/git.nix
  ];

  home = {
    username = "raexera";
    homeDirectory = "/home/raexera";
    extraOutputsToInstall = ["doc" "devdoc"];
  };

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  programs.home-manager.enable = true;
}
