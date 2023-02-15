{
  outputs,
  inputs,
}: let
  # Adds my custom packages
  additions = final: _: import ../pkgs {pkgs = final;};

  # Modifies existing packages
  modifications = final: prev: {
    discord-canary = prev.discord-canary.override {
      nss = prev.nss_latest;
      withOpenASAR = true;
    };

    ncmpcpp = prev.ncmpcpp.overrideAttrs (old: rec {
      src = prev.fetchFromGitHub {
        owner = "ncmpcpp";
        repo = "ncmpcpp";
        rev = "417d7172e5587f4302f92ea6377268dca7f726ad";
        sha256 = "LRf/iWxRO9zX+MZxIQbscslicaWzN7kokzJLUVg7T38=";
      };

      nativeBuildInputs = old.nativeBuildInputs ++ [prev.autoconf prev.automake prev.libtool];
      preConfigure = "./autogen.sh";
    });

    picom = inputs.nixpkgs-f2k.packages.${prev.system}.picom-git;
    vaapiIntel = prev.vaapiIntel.override {enableHybridCodec = true;};
  };
in {
  default = final: prev: (additions final prev) // (modifications final prev);
}
