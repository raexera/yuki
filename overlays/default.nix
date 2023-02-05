{
  outputs,
  inputs,
}: let
  # Adds my custom packages
  additions = final: _: import ../pkgs {pkgs = final;};

  # Modifies existing packages
  modifications = final: prev: {
    picom = inputs.nixpkgs-f2k.packages.${prev.system}.picom-git;
    vaapiIntel = prev.vaapiIntel.override {enableHybridCodec = true;};
    wezterm = inputs.nixpkgs-f2k.packages.${prev.system}.wezterm-git;
  };
in {
  default = final: prev: (additions final prev) // (modifications final prev);
}
