{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrValues {
    inherit
      (pkgs)
      catimg
      duf
      du-dust
      file
      joshuto
      perl
      ranger
      yt-dlp
      ;
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
    exa.enable = true;

    gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnupg";
    };

    bat = {
      enable = true;
      config = {
        pager = "never";
        style = "plain";
        theme = "base16";
      };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    dircolors = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
