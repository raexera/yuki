{
  pkgs,
  themes,
  ...
}: {
  programs.vscode = {
    mutableExtensionsDir = true;
    extensions =
      (with pkgs.vscode-extensions; [
        github.vscode-github-actions
        github.vscode-pull-request-github
      ])
      ++ (with pkgs.vscode-marketplace; [
        antfu.icons-carbon
        bradlc.vscode-tailwindcss
        christian-kohler.path-intellisense
        dbaeumer.vscode-eslint
        denoland.vscode-deno
        editorconfig.editorconfig
        esbenp.prettier-vscode
        formulahendry.docker-explorer
        github.copilot
        github.copilot-chat
        golang.go
        jnoortheen.nix-ide
        llvm-vs-code-extensions.vscode-clangd
        mads-hartmann.bash-ide-vscode
        mikestead.dotenv
        mkhl.direnv
        mkhl.shfmt
        ms-azuretools.vscode-docker
        ms-python.black-formatter
        ms-python.isort
        ms-python.pylint
        ms-python.python
        ms-python.vscode-pylance
        ms-toolsai.jupyter
        ms-toolsai.jupyter-renderers
        ms-toolsai.jupyter-keymap
        ms-toolsai.vscode-jupyter-cell-tags
        ms-toolsai.vscode-jupyter-slideshow
        naumovs.color-highlight
        oderwat.indent-rainbow
        redhat.java
        redhat.vscode-yaml
        usernamehw.errorlens
        vscjava.vscode-java-debug
        vscjava.vscode-java-dependency
        vscjava.vscode-java-test
        xaver.clang-format
        yzhang.markdown-all-in-one
      ])
      ++ (with pkgs.vscode-marketplace-release; [
        eamodio.gitlens
        vadimcn.vscode-lldb
      ]);
  };
}
