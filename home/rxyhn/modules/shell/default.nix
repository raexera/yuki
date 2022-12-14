{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  browser = ["firefox.desktop"];
  associations = {
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/x-extension-xht" = browser;
    "application/x-extension-xhtml" = browser;
    "application/xhtml+xml" = browser;
    "text/html" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/chrome" = ["chromium-browser.desktop"];
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/unknown" = browser;

    "audio/*" = ["mpv.desktop"];
    "video/*" = ["mpv.dekstop"];
    "image/*" = ["imv.desktop"];
    "application/json" = browser;
    "application/pdf" = ["org.pwmt.zathura.desktop.desktop"];
    "x-scheme-handler/discord" = ["discordcanary.desktop"];
    "x-scheme-handler/spotify" = ["spotify.desktop"];
    "x-scheme-handler/tg" = ["telegramdesktop.desktop"];
  };
in {
  imports = [
    ./cli.nix
    ./git.nix
    ./nix.nix
    ./starship.nix
    ./transient-services.nix
    ./zsh.nix
  ];

  home = {
    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
    ];

    sessionVariables = {
      GOPATH = "${config.home.homeDirectory}/Extras/go";
      RUSTUP_HOME = "${config.home.homeDirectory}/.local/share/rustup";
    };

    file = {
      ".local/bin/updoot" = with pkgs; {
        executable = true;
        text = ''
          [ -f "$1" ] && op="cat"
          ''${op:-echo} "''${@:-$(cat -)}" \
            | ${curl}/bin/curl -sF file='@-' 'http://0x0.st' \
            | tee /dev/stderr \
            | tr -d '\n'      \
            | ${wl-clipboard}/bin/wl-copy
        '';
      };
    };
  };

  services = {
    syncthing.enable = true;

    gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
      enableZshIntegration = true;
      enableSshSupport = true;
    };
  };

  programs = {
    ssh.enable = true;

    gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnupg";
    };
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_DEVELOPMENT_DIR = "${config.xdg.userDirs.documents}/Dev";
      };
    };

    mimeApps = {
      enable = true;
      associations.added = associations;
      defaultApplications = associations;
    };
  };
}
