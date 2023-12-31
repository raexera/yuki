{
  lib,
  pkgs,
  ...
}: {
  systemd.user.services.swaybg = {
    Unit = {
      Description = "Set the wallpaper";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${lib.getExe pkgs.swaybg} -m fill -i ${../assets/wallpaper.png}";
      Restart = "on-failure";
    };
    Install.WantedBy = ["graphical-session.target"];
  };
}
