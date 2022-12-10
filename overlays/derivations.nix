final: prev: {
  sf-mono-liga = prev.callPackage ../derivations/sf-mono-liga.nix {
    src = prev.sf-mono-liga-src;
    version = "999-master";
  };
}
