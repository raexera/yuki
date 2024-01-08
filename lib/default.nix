{lib, ...}: {
  _module.args = {
    default = import ./themes lib;
    colors = import ./colors lib;
  };
}
