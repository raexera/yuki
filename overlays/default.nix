{
  outputs,
  inputs,
}: {
  # Adds my custom packages
  additions = final: _prev: import ../pkgs {pkgs = final;};

  # Modifies existing packages
  modifications = final: prev: {};
}
