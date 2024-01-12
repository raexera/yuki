{
  pkgs,
  default,
  ...
}: let
  mimeTypes = [
    "application/javascript"
    "application/sql"
    "application/toml"
    "application/x-shellscript"
    "application/yaml"
    "text/css"
    "text/english"
    "text/html"
    "text/javascript"
    "text/markdown"
    "text/plain"
    "text/rust"
    "text/x-c"
    "text/x-c++"
    "text/x-c++hdr"
    "text/x-c++src"
    "text/x-chdr"
    "text/x-cmake"
    "text/x-csrc"
    "text/x-go"
    "text/x-java"
    "text/x-kotlin"
    "text/x-lua"
    "text/x-makefile"
    "text/x-python"
    "text/x-scss"
  ];
in {
  xdg.mimeApps.defaultApplications = builtins.listToAttrs (map (mimeType: {
      name = mimeType;
      value = ["code.desktop"];
    })
    mimeTypes);

  programs.vscode = let
    xcolors = pkgs.lib.colors.xcolors default.colorscheme.colors;
  in {
    enable = true;
    mutableExtensionsDir = true;
    extensions =
      (with pkgs.vscode-extensions; [
        ms-vscode.cpptools
      ])
      ++ (with pkgs.vscode-marketplace-release; [
        eamodio.gitlens
        vadimcn.vscode-lldb
      ])
      ++ (with pkgs.vscode-marketplace; [
        antfu.icons-carbon
        bbenoist.nix
        catppuccin.catppuccin-vsc-icons
        christian-kohler.path-intellisense
        dbaeumer.vscode-eslint
        denoland.vscode-deno
        editorconfig.editorconfig
        esbenp.prettier-vscode
        formulahendry.code-runner
        foxundermoon.shell-format
        github.copilot
        github.copilot-chat
        github.vscode-github-actions
        github.vscode-pull-request-github
        golang.go
        kamadorueda.alejandra
        mechatroner.rainbow-csv
        mikestead.dotenv
        mkhl.direnv
        ms-azuretools.vscode-docker
        ms-python.black-formatter
        ms-python.isort
        ms-python.python
        ms-python.vscode-pylance
        ms-vscode.cmake-tools
        naumovs.color-highlight
        oderwat.indent-rainbow
        redhat.vscode-yaml
        shardulm94.trailing-spaces
        timonwong.shellcheck
        twxs.cmake
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
            all = {
              text = "${xcolors.white}";
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

    userSettings = {
      "[c]"."editor.defaultFormatter" = "xaver.clang-format";
      "[cpp]"."editor.defaultFormatter" = "xaver.clang-format";
      "[css]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[json]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[jsonc]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[less]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[nix]"."editor.defaultFormatter" = "kamadorueda.alejandra";
      "[python]"."editor.defaultFormatter" = "ms-python.black-formatter";
      "[scss]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";

      "breadcrumbs.enabled" = true;
      "breadcrumbs.symbolPath" = "last";

      "editor.acceptSuggestionOnEnter" = "smart";
      "editor.autoIndent" = "full";
      "editor.bracketPairColorization.enabled" = true;
      "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
      "editor.cursorBlinking" = "smooth";
      "editor.cursorSmoothCaretAnimation" = "on";
      "editor.fontFamily" = "'monospace', monospace, 'Material Design Icons'";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 13;
      "editor.fontWeight" = "500";
      "editor.formatOnPaste" = true;
      "editor.formatOnSave" = true;
      "editor.formatOnType" = true;
      "editor.guides.bracketPairs" = true;
      "editor.guides.indentation" = true;
      "editor.inlayHints.enabled" = "onUnlessPressed";
      "editor.inlayHints.padding" = true;
      "editor.inlineSuggest.enabled" = true;
      "editor.linkedEditing" = true;
      "editor.lineHeight" = 22;
      "editor.lineNumbers" = "on";
      "editor.minimap.enabled" = false;
      "editor.minimap.renderCharacters" = false;
      "editor.renderLineHighlight" = "all";
      "editor.renderWhitespace" = "none";
      "editor.semanticHighlighting.enabled" = true;
      "editor.showUnused" = true;
      "editor.smoothScrolling" = true;
      "editor.tabCompletion" = "on";
      "editor.tabSize" = 2;
      "editor.trimAutoWhitespace" = true;
      "editor.wordWrap" = "on";

      "files.autoSave" = "onFocusChange";
      "files.insertFinalNewline" = true;
      "files.trimTrailingWhitespace" = true;

      "git.autofetch" = true;
      "git.enableSmartCommit" = true;

      "github.copilot.enable" = {
        "*" = true;
      };
      "githubPullRequests.pullBranch" = "always";

      "gitlens.views.repositories.files.layout" = "tree";

      "gopls" = {
        "ui.semanticTokens" = true;
      };

      "terminal.integrated.cursorBlinking" = true;
      "terminal.integrated.cursorStyle" = "line";
      "terminal.integrated.cursorWidth" = 2;
      "terminal.integrated.fontFamily" = "'monospace'";
      "terminal.integrated.fontSize" = 13;
      "terminal.integrated.minimumContrastRatio" = 1;
      "terminal.integrated.smoothScrolling" = true;

      "window.autoDetectColorScheme" = true;
      "window.menuBarVisibility" = "toggle";
      "window.titleBarStyle" = "custom";
      "window.zoomLevel" = 1;

      "workbench.colorTheme" = "Catppuccin Macchiato";
      "workbench.editor.enablePreview" = false;
      "workbench.editor.enablePreviewFromQuickOpen" = false;
      "workbench.iconTheme" = "catppuccin-macchiato";
      "workbench.panel.defaultLocation" = "right";
      "workbench.productIconTheme" = "icons-carbon";
      "workbench.tree.renderIndentGuides" = "always";
      "workbench.sideBar.location" = "right";
      "workbench.startupEditor" = "none";
    };
  };
}
