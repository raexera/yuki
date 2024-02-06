{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.cloudflare-warp
  ];

  systemd = {
    packages = [pkgs.cloudflare-warp];

    services.warp-svc = {
      after = ["network-online.target" "systemd-resolved.service"];
      wantedBy = ["multi-user.target"];
    };

    user.services."warp-taskbar".wantedBy = ["tray.target"];
  };
}
