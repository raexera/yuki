{
  pkgs,
  themes,
  ...
}: {
  programs.vscode = {
    mutableExtensionsDir = true;
    extensions = with pkgs.vscode-marketplace;
      [
        alefragnani.project-manager
        astro-build.astro-vscode
        bradlc.vscode-tailwindcss
        cardinal90.multi-cursor-case-preserve
        catppuccin.catppuccin-vsc-icons
        christian-kohler.npm-intellisense
        christian-kohler.path-intellisense
        dbaeumer.vscode-eslint
        eamodio.gitlens
        editorconfig.editorconfig
        emeraldwalk.runonsave
        esbenp.prettier-vscode
        formulahendry.auto-complete-tag
        formulahendry.code-runner
        golang.go
        jnoortheen.nix-ide
        meganrogge.template-string-converter
        mikestead.dotenv
        mkhl.direnv
        ms-azuretools.vscode-docker
        ms-kubernetes-tools.vscode-kubernetes-tools
        naumovs.color-highlight
        oderwat.indent-rainbow
        redhat.java
        redhat.vscode-yaml
        renesaarsoo.sql-formatter-vsc
        rust-lang.rust-analyzer
        svelte.svelte-vscode
        tamasfe.even-better-toml
        usernamehw.errorlens
        vscjava.vscode-java-debug
        vscjava.vscode-java-dependency
        vscjava.vscode-java-test
        vscjava.vscode-maven
        vscjava.vscode-spring-initializr
        yzhang.markdown-all-in-one
      ]
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
              blue = "${xcolors.blue}";
              sky = "${xcolors.sky}";
              lavender = "${xcolors.lavender}";
              crust = "${xcolors.black0}";
              mantle = "${xcolors.black1}";
              base = "${xcolors.black2}";
              surface0 = "${xcolors.black3}";
              surface1 = "${xcolors.black4}";
              surface2 = "${xcolors.gray0}";
              overlay0 = "${xcolors.gray1}";
              overlay1 = "${xcolors.gray2}";
              text = "${xcolors.white}";
            };
          };
          customUIColors = {};
        })
      ];
  };
}
