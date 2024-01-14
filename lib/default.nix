{lib, ...}: {
  _module.args = {
    colors = import ./colors lib;
    themes = import ./themes lib;
  };
}
