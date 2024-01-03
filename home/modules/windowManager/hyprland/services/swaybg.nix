{
  lib,
  pkgs,
  ...
}: {
  systemd.user.services.swaybg = let
    wallpaper = builtins.fetchurl rec {
      name = "wallpaper-${sha256}.png";
      url = "https://media.githubusercontent.com/media/rxyhn/wallpapers/main/anime/wallpaper.png";
      sha256 = "0jbnr6qhqdwki0rzbq4x41car77mpdfpb0p2v7yfwl15m4f1ibkm";
    };
  in {
    Unit = {
      Description = "Wayland wallpaper daemon";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };

    Service = {
      ExecStart = "${lib.getExe pkgs.swaybg} --mode fill --image ${wallpaper}";
      Restart = "on-failure";
    };

    Install.WantedBy = ["graphical-session.target"];
  };
}
