{pkgs, ...}: {
  systemd.packages = [
    pkgs.cloudflare-warp
  ];

  systemd.services."warp-svc".wantedBy = ["multi-user.target"];
  systemd.user.services."warp-taskbar".wantedBy = ["tray.target"];

  environment.systemPackages = [
    pkgs.cloudflare-warp
  ];
}
