{
  pkgs,
  lib,
  ...
}: {
  fonts = {
    packages = with pkgs; [
      material-icons
      material-design-icons
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      roboto

      (google-fonts.override {fonts = ["Dosis" "Inter"];})
      (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
    ];

    enableDefaultPackages = false;

    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Noto Color Emoji"];
      sansSerif = ["Dosis" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };

  hardware.pulseaudio.enable = lib.mkForce false;

  location.provider = "geoclue2";

  nix = {
    settings = {
      substituters = [
        "https://hyprland.cachix.org"
      ];

      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };

  programs = {
    dconf.enable = true;
    kdeconnect.enable = true;
    seahorse.enable = true;
  };

  services = {
    geoclue2.enable = true;
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
    power-profiles-daemon.enable = true;

    psd = {
      enable = true;
      resyncTimer = "10m";
    };

    dbus = {
      enable = true;
      packages = with pkgs; [dconf gcr udisks2];
    };

    udev.packages = with pkgs; [gnome.gnome-settings-daemon android-udev-rules];

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };

      pulse.enable = true;
      wireplumber.enable = true;
      jack.enable = true;
    };
  };

  security = {
    pam.services.swaylock.text = "auth include login";
    rtkit.enable = true;
  };

  environment.variables.GTK_USE_PORTAL = "1";

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}
