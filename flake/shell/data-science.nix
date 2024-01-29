{pkgs}: let
  pythonEnv = pkgs.python3.withPackages (p:
    with p; [
      jupyterlab_server
      jupyter_core
      jupyter
      ipython
      ipykernel
      notebook
      matplotlib
      numpy
      toolz
      pandas
    ]);
in
  pkgs.mkShell {
    nativeBuildInputs = [pythonEnv];
  }
