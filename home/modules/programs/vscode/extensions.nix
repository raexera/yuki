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
        catppuccin.catppuccin-vsc-icons
        christian-kohler.path-intellisense
        dbaeumer.vscode-eslint
        denoland.vscode-deno
        editorconfig.editorconfig
        esbenp.prettier-vscode
        github.copilot
        github.copilot-chat
        jnoortheen.nix-ide
        llvm-vs-code-extensions.vscode-clangd
        mads-hartmann.bash-ide-vscode
        mikestead.dotenv
        mkhl.direnv
        mkhl.shfmt
        ms-python.black-formatter
        ms-python.isort
        ms-python.pylint
        ms-python.python
        ms-python.vscode-pylance
        ms-vscode.cmake-tools
        ms-vscode.cpptools
        ms-vscode.makefile-tools
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
      ])
      ++ [
        (pkgs.catppuccin-vsc.override {
          accent = "blue";
          boldKeywords = true;
          italicComments = true;
          italicKeywords = true;
          extraBordersEnabled = false;
          workbenchMode = "default";
          bracketMode = "rainbow";
          colorOverrides = {
            all = let
              inherit (themes.colorscheme) xcolors;
            in {
              rosewater = "${xcolors.rosewater}";
              flamingo = "${xcolors.flamingo}";
              pink = "${xcolors.pink}";
              mauve = "${xcolors.mauve}";
              red = "${xcolors.red}";
              maroon = "${xcolors.maroon}";
              peach = "${xcolors.peach}";
              yellow = "${xcolors.yellow}";
              green = "${xcolors.green}";
              teal = "${xcolors.teal}";
              sky = "${xcolors.sky}";
              blue = "${xcolors.blue}";
              lavender = "${xcolors.lavender}";
              text = "${xcolors.white}";
              surface2 = "${xcolors.gray1}";
              surface1 = "${xcolors.gray0}";
              surface0 = "${xcolors.black3}";
              base = "${xcolors.black2}";
              mantle = "${xcolors.black1}";
              crust = "${xcolors.black0}";
            };
          };
          customUIColors = {
            all = {
              "statusBar.foreground" = "accent";
              "statusBar.noFolderForeground" = "accent";
            };
          };
        })
      ];
  };
}
