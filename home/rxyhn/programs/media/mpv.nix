{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    config = {
      border = false;
      gpu-context = "wayland";
      hwdec = "auto";
      osc = false;
      profile = "gpu-hq";
      vo = "gpu";
    };
    scripts = with pkgs.mpvScripts; [mpris thumbnail sponsorblock];
  };
}
