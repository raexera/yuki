{
  perSystem = {pkgs, ...}: {
    packages = {
      lightctl = pkgs.callPackage ./lightctl {};
      networkctl = pkgs.callPackage ./networkctl {};
      volumectl = pkgs.callPackage ./volumectl {};
    };
  };
}
