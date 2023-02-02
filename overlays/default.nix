{
  outputs,
  inputs,
}: {
  additions = final: _prev: import ../pkgs {pkgs = final;};

  modifications = final: prev: {
    awesome = inputs.nixpkgs-f2k.packages.${pkgs.system}.awesome-git;
    vaapiIntel = prev.vaapiIntel.override {enableHybridCodec = true;};
  };
}
