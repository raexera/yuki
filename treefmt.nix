{inputs, ...}: {
  imports = [inputs.treefmt-nix.flakeModule];

  perSystem.treefmt = {
    projectRootFile = "flake.nix";

    programs = {
      alejandra.enable = true;
      black.enable = true;
      deadnix.enable = true;
      prettier.enable = true;
      shellcheck.enable = true;
      shfmt.enable = true;
    };
  };
}
