{lib, ...}: {
  _module.args = {
    colors = import ./colors lib;
  };
}
