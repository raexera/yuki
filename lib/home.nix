inputs: let
  extraSpecialArgs = {inherit inputs;};

  defArgs = {
    inherit extraSpecialArgs;
    pkgs = inputs.self.pkgs.x86_64-linux;
  };

  mkHome = args:
    inputs.hm.lib.homeManagerConfiguration (defArgs // args);
in {inherit mkHome extraSpecialArgs;}
