{
  pkgs,
  lib,
  ...
}: {
  fonts = {
    packages = with pkgs; [
      comfortaa
      dosis
      dejavu_fonts
      inter
      iosevka-bin
      material-design-icons
      material-icons
      material-symbols
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      roboto
      (nerdfonts.override {fonts = ["Iosevka" "JetBrainsMono"];})
    ];

    enableDefaultPackages = false;

    fontconfig.defaultFonts = {
      monospace = [
        "Iosevka Term"
        "Iosevka Term Nerd Font Complete Mono"
        "Iosevka Nerd Font"
        "Noto Color Emoji"
      ];
      sansSerif = ["Dosis" "Noto Color Emoji"];
      serif = ["Noto Serif" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };

  # environment.variables.NIXOS_OZONE_WL = "1";

  hardware = {
    opengl = {
      extraPackages = with pkgs; [
        libva
        vaapiVdpau
        libvdpau-va-gl
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        vaapiVdpau
        libvdpau-va-gl
      ];
    };

    pulseaudio.enable = lib.mkForce false;
  };

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

  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };

  services = {
    geoclue2.enable = true;
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
    power-profiles-daemon.enable = true;
    upower.enable = true;
    dbus.packages = [pkgs.gcr];

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

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = ["gtk"];
      hyprland.default = ["gtk" "hyprland"];
    };

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}
