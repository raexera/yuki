{
  systems = ["x86_64-linux"];

  perSystem = {pkgs, ...}: {
    packages = {
      firefox-gnome-theme = pkgs.callPackage ./firefox-gnome-theme {};
      tabler-icons = pkgs.callPackage ./tabler-icons {};
    };
  };
}
