{pkgs, ...}: {
  imports = [
    ./config
    ./dev
    ./programs
    ./services
    ./shell
    ./window-managers/hyprland

    ./home.nix
  ];

  home.packages = with pkgs; [
    atool
    brightnessctl
    coreutils
    curl
    du-dust
    duf
    editorconfig-core-c
    elinks
    exiftool
    fd
    file
    findutils
    gawk
    glow
    gnumake
    gnused
    imagemagick
    jaq
    jq
    killall
    p7zip
    pre-commit
    procs
    playerctl
    psmisc
    ripgrep
    rsync
    trash-cli
    tree
    unrar
    unzip
    util-linux
    vim
    watchexec
    wget
    wrk
    xarchiver
    xh
    yt-dlp
    yq
    zathura
    zip
  ];

  wayland.windowManager.hyprland.settings = let
    # Generated using https://gist.github.com/fufexan/e6bcccb7787116b8f9c31160fc8bc543
    accelpoints = "0.000 0.053 0.115 0.189 0.280 0.391 0.525 0.687 0.880 1.108 1.375 1.684 2.040 2.446 2.905 3.422 4.000 4.643 5.355 6.139";
  in {
    monitor = [
      # name, resolution, position, scale
      "eDP-1, preferred, auto, 1.600000"
    ];

    device = {
      name = "pnp0c50:00-06cb:cec0-touchpad";
      accel_profile = "custom ${accelpoints}";
      scroll_points = accelpoints;
      natural_scroll = true;
    };
  };
}
