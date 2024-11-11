{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./config
    ./scripts

    # launcher
    ./programs/anyrun.nix

    # bar
    ./programs/waybar.nix

    # notifications daemon
    ./services/dunst.nix

    # hypr utils
    ./services/hypridle.nix
    ./services/hyprlock.nix
    ./services/hyprpaper.nix
  ];

  home.packages = with pkgs; [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast

    kooha
    libnotify
    slurp
    grim
    swappy
    wf-recorder
    wl-clipboard
    wlr-randr
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    package = inputs.hyprland.packages.${pkgs.system}.default;

    systemd = {
      enable = true;
      variables = ["--all"];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };
}
