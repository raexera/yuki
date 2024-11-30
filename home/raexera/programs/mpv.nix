{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    config = {
      gpu-context = "wayland";
      hwdec = "auto";
      profile = "gpu-hq";
      vo = "gpu";
    };
    scripts = with pkgs.mpvScripts; [mpris thumbnail sponsorblock];
  };
}
