{pkgs, ...}: {
  systemd.packages = [
    pkgs.cloudflare-warp
  ];

  systemd.services."warp-svc".wantedBy = ["multi-user.target"];

  environment.systemPackages = [
    pkgs.cloudflare-warp
  ];
}
