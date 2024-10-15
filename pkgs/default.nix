{
  systems = ["x86_64-linux"];

  perSystem = {pkgs, ...}: {
    packages = {
      bibata-hyprcursor = pkgs.callPackage ./bibata-hyprcursor {};
    };
  };
}
