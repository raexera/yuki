{pkgs, ...}: {
  security.apparmor = {
    enable = true;
    killUnconfinedConfinables = true;
    packages = [pkgs.apparmor-profiles];
  };
}
