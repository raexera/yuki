{pkgs, ...}: {
  systemd.user.services.swayosd = {
    Unit = {
      Description = "Volume/backlight OSD indicator";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.swayosd}/bin/swayosd-server";
      Restart = "on-failure";
    };

    Install.WantedBy = ["graphical-session.target"];
  };
}
