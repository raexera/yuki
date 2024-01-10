{inputs, ...}: {
  imports = [inputs.treefmt-nix.flakeModule];

  perSystem.treefmt = {
    projectRootFile = "flake.nix";

    programs = {
      alejandra.enable = true;
      deadnix.enable = true;

      prettier = {
        enable = true;
        excludes = [".js" ".md" ".ts"];
      };

      shellcheck.enable = true;
      shfmt = {
        enable = true;
        indent_size = 2;
      };
    };
  };
}
