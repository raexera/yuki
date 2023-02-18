{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.windowManager.awesome;

  fzy = pkgs.callPackage ({
    luajit,
    fetchFromGitHub,
  }:
    luajit.pkgs.buildLuarocksPackage rec {
      pname = "fzy";
      version = "scm-1";
      src = fetchFromGitHub {
        owner = "swarn";
        repo = pname;
        rev = "0afc7bfaef9c8e6c3882069c7bf3d6548efa788e";
        hash = "sha256-WfHPRN2fC3qYLuHpJHoOzh7DnY7xZdCp8bN6kEKc7W8=";
      };
      propagatedBuildInputs = [luajit];
    }) {};
in {
  options.windowManager.awesome = {
    enable = mkEnableOption (lib.mdDoc "Awesome window manager");
  };

  config = mkIf cfg.enable {
    environment.systemPackages = attrValues {
      inherit
        (pkgs)
        maim
        lxrandr
        nemo-qml-plugin-dbus
        redshift
        sox
        xclip
        xdotool
        xsel
        ;

      inherit
        (pkgs.cinnamon)
        nemo
        ;

      inherit
        (pkgs.gnome3)
        dconf-editor
        ;

      inherit
        (pkgs.xfce)
        xfce4-clipman-plugin
        ;
    };

    services.xserver = {
      enable = true;
      dpi = 144;
      exportConfiguration = true;
      xkbOptions = "caps:escape";
      libinput = {
        enable = true;
        touchpad = {naturalScrolling = true;};
      };

      displayManager = {
        autoLogin = {
          enable = true;
          user = "rxyhn";
        };

        defaultSession = "none+awesome";
        lightdm.enable = true;
      };

      windowManager = {
        awesome = {
          enable = true;
          package = inputs.nixpkgs-f2k.packages.${pkgs.system}.awesome-git;
          luaModules = with pkgs.luajitPackages; [
            lgi
            ldbus
            luadbi-mysql
            luaposix
            fzy
          ];
        };
      };
    };
  };
}
