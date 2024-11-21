{lib, ...}: {
  _module.args = {
    themes = import ./themes lib;
  };
}
