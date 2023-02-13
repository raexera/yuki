{pkgs, ...}:
[
  (pkgs.python3.withPackages (p:
    with p; [
      pygobject3
    ]))
]
++ [pkgs.gobject-introspection pkgs.pipenv]
