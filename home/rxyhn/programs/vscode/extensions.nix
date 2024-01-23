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
        (jnoortheen.nix-ide.overrideAttrs (prev: {
          nativeBuildInputs = prev.nativeBuildInputs ++ [pkgs.jq pkgs.moreutils];
          postInstall = ''
            cd "$out/$installPrefix"
            jq -e '
              .contributes.configuration.properties."nix.formatterPath".default =
                "${pkgs.alejandra}/bin/alejandra" |
              .contributes.configuration.properties."nix.enableLanguageServer".default =
                "true" |
              .contributes.configuration.properties."nix.serverPath".default =
                "${pkgs.nil}/bin/nil" |
              .contributes.configuration.properties."nix.serverSettings".default.nil.formatting.command[0] =
                "${pkgs.alejandra}/bin/alejandra"
            ' < package.json | sponge package.json
          '';
        }))
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
        formulahendry.code-runner
        github.copilot
        github.vscode-github-actions
        github.vscode-pull-request-github
        golang.go
        mikestead.dotenv
        mkhl.direnv
        mkhl.shfmt
        ms-python.python
        ms-python.vscode-pylance
        ms-pyright.pyright
        ms-vscode.cmake-tools
        ms-vscode.cpptools
        naumovs.color-highlight
        oderwat.indent-rainbow
        redhat.java
        redhat.vscode-yaml
        sumneko.lua
        usernamehw.errorlens
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
