{inputs, ...}: {
  imports = [
    {
      _module.args = {theme = import ./theme.nix inputs;};
    }
  ];
}
