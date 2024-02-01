{inputs, ...}: {
  imports = [inputs.nix-index-db.hmModules.nix-index];

  config = {
    home.sessionVariables = {
      NIX_AUTO_RUN = "1";
    };

    programs = {
      nix-index = {
        enable = true;
        symlinkToCacheHome = true;
      };

      nix-index-database.comma.enable = true;
    };
  };
}
