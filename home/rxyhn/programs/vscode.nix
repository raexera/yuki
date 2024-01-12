{
  pkgs,
  inputs,
  config,
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
              statusBar.foreground = "accent";
              statusBar.noFolderForeground = "accent";
            };
          };
        })
      ];

    userSettings = {
      "[c]".editor.defaultFormatter = "xaver.clang-format";
      "[cpp]".editor.defaultFormatter = "xaver.clang-format";
      "[css]".editor.defaultFormatter = "esbenp.prettier-vscode";
      "[html]".editor.defaultFormatter = "esbenp.prettier-vscode";
      "[javascript]".editor.defaultFormatter = "esbenp.prettier-vscode";
      "[json]".editor.defaultFormatter = "esbenp.prettier-vscode";
      "[jsonc]".editor.defaultFormatter = "esbenp.prettier-vscode";
      "[lua]".editor.defaultFormatter = "johnnymorganz.stylua";
      "[nix]".editor.defaultFormatter = "kamadorueda.alejandra";
      "[python]".editor.defaultFormatter = "ms-python.black-formatter";
      "[scss]".editor.defaultFormatter = "esbenp.prettier-vscode";
      "[typescript]".editor.defaultFormatter = "esbenp.prettier-vscode";

      editor = {
        bracketPairColorization = {
          enabled = true;
          independentColorPoolPerBracketType = true;
        };
        cursorBlinking = "smooth";
        cursorSmoothCaretAnimation = "on";
        fontFamily = "'monospace', monospace, 'Material Design Icons'";
        fontLigatures = true;
        fontSize = 13;
        formatOnPaste = true;
        formatOnSave = true;
        formatOnType = true;
        guides = {
          bracketPairs = true;
          indentation = true;
        };
        inlayHints.enabled = "off";
        inlineSuggest.enabled = true;
        largeFileOptimizations = false;
        lineNumbers = "on";
        linkedEditing = true;
        maxTokenizationLineLength = 60000;
        minimap.enabled = false;
        overviewRulerBorder = false;
        quickSuggestions.strings = true;
        renderLineHighlight = "all";
        renderWhitespace = "none";
        smoothScrolling = true;
        suggest.showStatusBar = true;
        suggestSelection = "first";
      };

      explorer = {
        confirmDelete = true;
        confirmDragAndDrop = false;
      };

      files = {
        eol = "\n";
        insertFinalNewline = true;
        trimTrailingWhitespace = true;
      };

      git = {
        autofetch = true;
        confirmSync = false;
        enableSmartCommit = true;
      };

      github.copilot.enable."*" = true;
      githubPullRequests.pullBranch = "always";
      security.workspace.trust.enabled = false;

      terminal.integrated = {
        cursorBlinking = true;
        cursorStyle = "line";
        cursorWidth = 2;
        fontFamily = "'monospace'";
        fontSize = 13;
        smoothScrolling = true;
      };

      window = {
        autoDetectColorScheme = true;
        menuBarVisibility = "toggle";
        nativeTabs = true;
        titleBarStyle = "custom";
        zoomLevel = 1;
      };

      workbench = {
        colorTheme = "Catppuccin Macchiato";
        iconTheme = "catppuccin-macchiato";
        productIconTheme = "icons-carbon";
        panel.defaultLocation = "right";
        sideBar.location = "right";
      };
    };
  };
}
