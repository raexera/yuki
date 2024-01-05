{
  lib,
  pkgs,
  config,
  ...
}: {
  systemd.user.services.swaybg = {
    Unit = {
      Description = "Wayland wallpaper daemon";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };

    Service = {
      ExecStart = "${lib.getExe pkgs.swaybg} --mode fill --image ${config.wallpaper}";
      Restart = "on-failure";
    };

    Install.WantedBy = ["graphical-session.target"];
  };
}
