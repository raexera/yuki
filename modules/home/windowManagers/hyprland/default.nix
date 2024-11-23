{
  pkgs,
  self,
  ...
}: {
  imports = [
    ./config
    ./programs
    ./services

    self.homeManagerModules.config.cursor
    self.homeManagerModules.config.gtk
    self.homeManagerModules.config.qt
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
