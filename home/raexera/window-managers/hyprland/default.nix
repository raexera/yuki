{
  pkgs,
  self,
  ...
}: {
  imports = [
    ./config/binds.nix
    ./config/rules.nix
    ./config/settings.nix
    ./programs/anyrun.nix
    ./programs/waybar.nix
    ./services/dunst.nix
    ./services/hypridle.nix
    ./services/hyprlock.nix
    ./services/hyprpaper.nix
    ./services/polkit-agent.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = with pkgs.hyprlandPlugins; [
      hyprexpo
    ];
    systemd = {
      enable = true;
      variables = ["--all"];
    };
  };

  home.packages = with pkgs; [
    grimblast
    kooha
    libnotify
    slurp
    grim
    swappy
    wf-recorder
    wl-clipboard
    wlr-randr
    self.packages.${pkgs.system}.lightctl
    self.packages.${pkgs.system}.networkctl
    self.packages.${pkgs.system}.volumectl
  ];
}
