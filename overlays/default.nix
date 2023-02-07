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

    ncmpcpp = prev.ncmpcpp.override {
      visualizerSupport = true;
      clockSupport = true;
      taglibSupport = true;
    };

    picom = inputs.nixpkgs-f2k.packages.${prev.system}.picom-git;
    vaapiIntel = prev.vaapiIntel.override {enableHybridCodec = true;};
    wezterm = inputs.nixpkgs-f2k.packages.${prev.system}.wezterm-git;
  };
in {
  default = final: prev: (additions final prev) // (modifications final prev);
}
