{
  config,
  pkgs,
  ...
}: {
  environment = {
    sessionVariables = {
      NAUTILUS_EXTENSION_DIR = "${config.system.path}/lib/nautilus/extensions-4";
    };

    pathsToLink = [
      "/share/nautilus-python/extensions"
    ];

    systemPackages = with pkgs; [
      ffmpegthumbnailer
      gnome.adwaita-icon-theme
      gnome.dconf-editor
      gnome.gnome-tweaks
      gnome.nautilus-python
      nautilus-open-any-terminal
      wl-clipboard
    ];

    gnome.excludePackages =
      (with pkgs; [
        # gnome-text-editor
        gnome-console
        gnome-photos
        gnome-tour
        gnome-connections
        snapshot
        gedit
      ])
      ++ (with pkgs.gnome; [
        cheese # webcam tool
        gnome-music
        epiphany # web browser
        geary # email reader
        evince # document viewer
        gnome-characters
        totem # video player
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
        yelp # Help view
        gnome-contacts
        gnome-initial-setup
        gnome-shell-extensions
        gnome-maps
        gnome-font-viewer
      ]);
  };

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverridePackages = [
        pkgs.nautilus-open-any-terminal
      ];
    };
  };

  services.udev.packages = with pkgs; [gnome.gnome-settings-daemon];

  programs.dconf.profiles = {
    gdm.databases = [
      {
        settings = {
          "org/gnome/mutter".experimental-features = ["scale-monitor-framebuffer"];
          "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
          "org/gnome/desktop/peripherals/touchpad".tap-to-click = true;
        };
      }
    ];
  };
}
