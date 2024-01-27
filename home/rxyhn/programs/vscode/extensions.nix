{
  pkgs,
  themes,
  ...
}: {
  programs.vscode = {
    mutableExtensionsDir = true;
    extensions =
      (with pkgs.vscode-marketplace-release; [
        eamodio.gitlens
        vadimcn.vscode-lldb
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
        github.vscode-github-actions
        github.vscode-pull-request-github
        golang.go
        jnoortheen.nix-ide
        johnnymorganz.stylua
        llvm-vs-code-extensions.vscode-clangd
        mikestead.dotenv
        mkhl.direnv
        ms-python.black-formatter
        ms-python.isort
        ms-python.pylint
        ms-python.python
        ms-python.vscode-pylance
        ms-vscode.cmake-tools
        ms-vscode.cpptools
        ms-vscode.makefile-tools
        naumovs.color-highlight
        oderwat.indent-rainbow
        redhat.java
        redhat.vscode-yaml
        sumneko.lua
        usernamehw.errorlens
        xaver.clang-format
        yzhang.markdown-all-in-one
      ])
      ++ [
        (pkgs.catppuccin-vsc.override {
          accent = "blue";
          boldKeywords = true;
          italicComments = true;
          italicKeywords = true;
          extraBordersEnabled = true;
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
