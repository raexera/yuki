{pkgs, ...}: let
  general = {
    "extensions.ignoreRecommendations" = true;
    "extensions.autoCheckUpdates" = false;
    "extensions.autoUpdate" = false;
    "update.mode" = "none";
    "update.showReleaseNotes" = false;
  };

  editor = {
    "editor.bracketPairColorization.enabled" = true;
    "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
    "editor.cursorBlinking" = "smooth";
    "editor.cursorSmoothCaretAnimation" = "on";
    "editor.folding" = true;
    "editor.fontFamily" = "JetBrains Mono";
    "editor.fontLigatures" = true;
    "editor.fontSize" = 13;
    "editor.fontWeight" = "500";
    "editor.formatOnPaste" = true;
    "editor.formatOnSave" = true;
    "editor.formatOnType" = true;
    "editor.guides.bracketPairs" = true;
    "editor.guides.indentation" = true;
    "editor.inlayHints.fontSize" = 11;
    "editor.inlayHints.padding" = true;
    "editor.inlineSuggest.enabled" = true;
    "editor.linkedEditing" = true;
    "editor.lineHeight" = 22;
    "editor.lineNumbers" = "on";
    "editor.minimap.enabled" = false;
    "editor.parameterHints.enabled" = true;
    "editor.renderLineHighlight" = "all";
    "editor.scrollbar.horizontal" = "hidden";
    "editor.semanticHighlighting.enabled" = true;
    "editor.showUnused" = true;
    "editor.snippetSuggestions" = "top";
    "editor.stickyScroll.enabled" = true;
    "editor.tabCompletion" = "on";
    "editor.tabSize" = 2;
    "editor.trimAutoWhitespace" = true;
    "editor.wordWrap" = "on";
    "editor.wrappingIndent" = "indent";
    "editor.quickSuggestionsDelay" = 300;
    "editor.quickSuggestions"."strings" = "on";
    "editor.codeActionsOnSave" = {
      "source.fixAll" = "always";
      "source.organizeImports" = "always";
    };
  };

  breadcrumbs = {
    "breadcrumbs.enabled" = false;
    "breadcrumbs.symbolPath" = "off";
    "breadcrumbs.filePath" = "on";
  };

  explorer = {
    "explorer.confirmDelete" = false;
    "explorer.confirmDragAndDrop" = false;
  };

  files = {
    "files.eol" = "\n";
    "files.autoSave" = "onWindowChange";
    "files.trimTrailingWhitespace" = true;
    "files.trimFinalNewlines" = true;
    "files.insertFinalNewline" = true;
    "files.exclude" = {
      "**/.direnv" = true;
      "**/result" = true;
    };
  };

  telemetry = {
    "redhat.telemetry.enabled" = false;
    "telemetry.telemetryLevel" = "off";
  };

  terminal = {
    "terminal.integrated.fontFamily" = "JetBrains Mono";
    "terminal.integrated.fontSize" = 13;
    "terminal.integrated.gpuAcceleration" = "on";
  };

  window = {
    "window.commandCenter" = false;
    "window.dialogStyle" = "native";
    "window.menuBarVisibility" = "toggle";
    "window.titleBarStyle" = "custom";
    "window.zoomLevel" = 1;
  };

  workbench = {
    "workbench.activityBar.location" = "top";
    "workbench.colorTheme" = "GitHub Dark Default";
    "workbench.iconTheme" = "material-icon-theme";
    "workbench.layoutControl.enabled" = false;
    "workbench.panel.defaultLocation" = "bottom";
    "workbench.productIconTheme" = "icons-carbon";
    "workbench.sideBar.location" = "right";
    "workbench.startupEditor" = "none";
    "workbench.tree.indent" = 16;
  };

  # Extension settings
  extension = {
    # git
    "git.autofetch" = true;
    "git.enableCommitSigning" = true;
    "git.enableSmartCommit" = true;
    "git.openRepositoryInParentFolders" = "always";

    # github
    "github.copilot.editor.enableAutoCompletions" = true;
    "github.copilot.enable" = {
      "*" = true;
    };

    # errorLens
    "errorLens.gutterIconsEnabled" = true;
    "errorLens.gutterIconSet" = "defaultOutline";

    # path-intellisense
    "path-intellisense.autoSlashAfterDirectory" = true;
    "path-intellisense.autoTriggerNextSuggestion" = true;
    "path-intellisense.extensionOnImport" = true;
    "path-intellisense.showHiddenFiles" = true;
  };

  # Formatter settings
  formatter = {
    "[astro]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[css]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[java]"."editor.defaultFormatter" = "redhat.java";
    "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[json]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[jsonc]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[markdown]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[nix]"."editor.defaultFormatter" = "jnoortheen.nix-ide";
    "[python]"."editor.defaultFormatter" = "ms-python.black-formatter";
    "[scss]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
  };

  # Language specific settings
  language = {
    # Go
    "go.alternateTools" = {
      "delve" = "${pkgs.delve}/bin/dlv";
      "gofumpt" = "${pkgs.gofumpt}/bin/gofumpt";
      "golangci-lint" = "${pkgs.golangci-lint}/bin/golangci-lint";
      "gomodifytags" = "${pkgs.gomodifytags}/bin/gomodifytags";
      "gopls" = "${pkgs.gopls}/bin/gopls";
      "impl" = "${pkgs.impl}/bin/impl";
      "staticcheck" = "${pkgs.go-tools}/bin/staticcheck";
    };
    "go.inlayHints.assignVariableTypes" = true;
    "go.inlayHints.compositeLiteralFields" = true;
    "go.inlayHints.compositeLiteralTypes" = true;
    "go.inlayHints.constantValues" = true;
    "go.inlayHints.functionTypeParameters" = true;
    "go.inlayHints.parameterNames" = true;
    "go.inlayHints.rangeVariableTypes" = true;
    "go.lintTool" = "golangci-lint";
    "go.useLanguageServer" = true;
    "gopls" = {
      "formatting.gofumpt" = true;
      "ui.semanticTokens" = true;
    };
    "emeraldwalk.runonsave" = {
      "commands" = [
        {
          "cmd" = "${pkgs.goimports-reviser}/bin/goimports-reviser -rm-unused -set-alias -format -use-cache -output write \${file}";
          "match" = "\\.go$";
        }
        {
          "cmd" = "${pkgs.golines}/bin/golines \${file} -w";
          "match" = "\\.go$";
        }
      ];
    };

    # Java
    "java.configuration.runtimes" = [
      {
        name = "JavaSE-17";
        path = "${pkgs.jdk17}/lib/openjdk";
        default = true;
      }
    ];
    "java.format.settings.profile" = "GoogleStyle";
    "java.jdt.ls.java.home" = "${pkgs.jdk17}/lib/openjdk";

    # Nix
    "nix.enableLanguageServer" = true;
    "nix.formatterPath" = "${pkgs.alejandra}/bin/alejandra";
    "nix.serverPath" = "${pkgs.nil}/bin/nil";
    "nix.serverSettings"."nil"."formatting"."command" = ["${pkgs.alejandra}/bin/alejandra"];

    # Python
    "python.defaultInterpreterPath" = "${pkgs.python3}/bin/python";
    "python.languageServer" = "Pylance";
    "python.analysis.typeCheckingMode" = "strict";
    "python.analysis.autoFormatStrings" = true;
  };
in {
  programs.vscode.userSettings =
    general
    // editor
    // breadcrumbs
    // explorer
    // files
    // telemetry
    // terminal
    // window
    // workbench
    // extension
    // formatter
    // language;
}
