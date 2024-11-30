{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      mpris
      sponsorblock
      thumbnail
    ];
    config = {
      gpu-context = "wayland";
      hwdec = "auto";
      osc = "no";
      profile = "gpu-hq";
      vo = "gpu";
    };
  };
}
