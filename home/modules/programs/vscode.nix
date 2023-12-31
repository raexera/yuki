{pkgs, ...}: {
  programs.vscode = {
    enable = true;

    mutableExtensionsDir = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      catppuccin.catppuccin-vsc
      christian-kohler.path-intellisense
      dbaeumer.vscode-eslint
      eamodio.gitlens
      editorconfig.editorconfig
      esbenp.prettier-vscode
      formulahendry.auto-close-tag
      formulahendry.auto-rename-tag
      formulahendry.code-runner
      foxundermoon.shell-format
      github.copilot
      github.copilot-chat
      github.vscode-github-actions
      github.vscode-pull-request-github
      golang.go
      ibm.output-colorizer
      kamadorueda.alejandra
      mechatroner.rainbow-csv
      mkhl.direnv
      ms-azuretools.vscode-docker
      ms-python.black-formatter
      ms-python.isort
      ms-python.python
      ms-python.vscode-pylance
      ms-vscode.cmake-tools
      ms-vscode.cpptools
      naumovs.color-highlight
      oderwat.indent-rainbow
      pkief.material-icon-theme
      pkief.material-product-icons
      redhat.vscode-yaml
      shardulm94.trailing-spaces
      timonwong.shellcheck
      twxs.cmake
      usernamehw.errorlens
      vadimcn.vscode-lldb
      xaver.clang-format
      yzhang.markdown-all-in-one
      zhuangtongfa.material-theme
    ];

    userSettings = {
      "[c]".editor.defaultFormatter = "xaver.clang-format";
      "[cpp]".editor.defaultFormatter = "xaver.clang-format";
      "[css]".editor.defaultFormatter = "esbenp.prettier-vscode";
      "[html]".editor.defaultFormatter = "esbenp.prettier-vscode";
      "[javascript]".editor.defaultFormatter = "rvest.vs-code-prettier-eslint";
      "[json]".editor.defaultFormatter = "esbenp.prettier-vscode";
      "[jsonc]".editor.defaultFormatter = "rvest.vs-code-prettier-eslint";
      "[lua]".editor.defaultFormatter = "johnnymorganz.stylua";
      "[nix]".editor.defaultFormatter = "kamadorueda.alejandra";
      "[python]".editor.defaultFormatter = "ms-python.black-formatter";
      "[scss]".editor.defaultFormatter = "sibiraj-s.vscode-scss-formatter";
      "[typescript]".editor.defaultFormatter = "rvest.vs-code-prettier-eslint";

      breadcrumbs.enabled = false;
      editor = {
        bracketPairColorization = {
          enabled = true;
          independentColorPoolPerBracketType = true;
        };
        cursorBlinking = "smooth";
        cursorSmoothCaretAnimation = "on";
        cursorWidth = 2;
        find.addExtraSpaceOnTop = false;
        fontFamily = "'monospace', monospace";
        fontLigatures = true;
        fontSize = 16;
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

      emmet.useInlineCompletions = true;
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
      security.workspace.trust.enabled = false;

      terminal.integrated = {
        cursorBlinking = true;
        cursorStyle = "line";
        cursorWidth = 2;
        fontFamily = "'monospace'";
        fontSize = 16;
        smoothScrolling = true;
      };

      window = {
        menuBarVisibility = "toggle";
        nativeTabs = true;
        titleBarStyle = "custom";
        zoomLevel = 1;
      };

      workbench = {
        colorTheme = "One Dark Pro Darker";
        iconTheme = "material-icon-theme";
        panel.defaultLocation = "right";
        productIconTheme = "material-product-icons";
        sideBar.location = "right";
      };
    };
  };
}
