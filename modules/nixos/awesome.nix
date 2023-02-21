{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.xserver.windowManager.awesome;

  # reinventing the wheel of the default awesomewm module
  getLuaPath = lib: dir: "${lib}/${dir}/lua/${pkgs.luajit.luaversion}";
  makeSearchPath = lib.concatMapStrings (
    path:
      " --search "
      + (getLuaPath path "share")
      + " --search "
      + (getLuaPath path "lib")
  );

  luaModules = lib.attrValues {
    inherit
      (pkgs.luajitPackages)
      lgi
      ldbus
      luadbi-mysql
      luaposix
      ;

    dbus_proxy = pkgs.callPackage ({
      luajit,
      luajitPackages,
      fetchFromGitHub,
    }:
      luajitPackages.buildLuaPackage rec {
        pname = "dbus_proxy";
        version = "0.10.3";
        name = "${pname}-${version}";

        src = fetchFromGitHub {
          owner = "stefano-m";
          repo = "lua-${pname}";
          rev = "v${version}";
          sha256 = "sha256-Yd8TN/vKiqX7NOZyy8OwOnreWS5gdyVMTAjFqoAuces=";
        };

        propagatedBuildInputs = [luajitPackages.lgi];
        buildPhase = ":";
        installPhase = ''
          mkdir -p "$out/share/lua/${luajit.luaversion}"
          cp -r src/${pname} "$out/share/lua/${luajit.luaversion}/"
        '';
      }) {};

    async-lua = pkgs.callPackage ({
      luajit,
      fetchFromGitHub,
    }:
      luajit.pkgs.buildLuarocksPackage rec {
        pname = "async.lua";
        version = "scm-1";

        src = fetchFromGitHub {
          owner = "sclu1034";
          repo = pname;
          rev = "f8d8f70a1ef1f7c4d5e3e65a36e0e23d65129e92";
          hash = "sha256-zWeIZkdO5uOHI2dkzseCEj8+BldH7X1ZtfIQhDFjaQY=";
        };

        preConfigure = ''
          ln -s rocks/${pname}-${version}.rockspec .
        '';

        propagatedBuildInputs = [luajit];
      }) {};

    lgi-async-extra = pkgs.callPackage ({
      async-lua,
      luajit,
      luajitPackages,
      fetchFromGitHub,
    }:
      luajit.pkgs.buildLuarocksPackage rec {
        pname = "lgi-async-extra";
        version = "scm-1";

        src = fetchFromGitHub {
          owner = "sclu1034";
          repo = pname;
          rev = "45281ceaf42140f131861ca6d1717912f94f0bfd";
          hash = "sha256-4Lydw1l3ETLzmsdQu53116rn2oV+XKDDpgxpa3yFbYM=";
        };

        preConfigure = ''
          ln -s rocks/${pname}-${version}.rockspec .
        '';

        propagatedBuildInputs = [async-lua luajit luajitPackages.lgi];
      }) {};

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
  };
in {
  options = {
    services.xserver.windowManager.awesome = {
      enable = mkEnableOption (lib.mdDoc "Awesome window manager");
    };
  };

  config = mkIf cfg.enable {
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

      windowManager.session =
        singleton
        {
          name = "awesome";
          start = ''
            ${pkgs.awesome-git-luajit}/bin/awesome ${makeSearchPath luaModules} &
            waitPID=$!
          '';
        };
    };

    environment.systemPackages = lib.attrValues {
      inherit
        (pkgs)
        awesome-git-luajit
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

      inherit
        (pkgs.xorg)
        xwininfo
        ;
    };
  };
}
