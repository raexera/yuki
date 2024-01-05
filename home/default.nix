{
  lib,
  self,
  ...
}: {
  home = {
    username = "rxyhn";
    homeDirectory = "/home/rxyhn";
    stateVersion = "23.11";
    extraOutputsToInstall = ["doc" "devdoc"];
  };

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  programs.home-manager.enable = true;

  nixpkgs.overlays = [
    (final: prev: {
      lib = prev.lib // {colors = import "${self}/lib/colors" lib;};
    })
  ];
}
