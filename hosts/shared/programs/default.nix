{pkgs, ...}: {
  programs = {
    bash.promptInit = ''eval "$(${lib.getExe pkgs.starship} init bash)"'';

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        curl
        glib
        glibc
        icu
        libunwind
        libuuid
        libsecret
        openssl
        stdenv.cc.cc
        util-linux
        zlib
      ];
    };

    java = {
      enable = true;
      package = pkgs.jre;
    };

    adb.enable = true;
    dconf.enable = true;
    nm-applet.enable = true;
    seahorse.enable = true;
    ssh.startAgent = true;
  };
}
