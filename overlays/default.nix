{inputs}: {
  # Adds my custom packages
  additions = final: _prev:
    import ../pkgs {
      pkgs = final;
      inherit inputs;
    };

  # Modifies existing packages
  modifications = final: prev: {};
}
