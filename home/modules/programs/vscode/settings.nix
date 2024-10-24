{pkgs, ...}: let
  # general
  editor = {
    "editor.bracketPairColorization.enabled" = true;
    "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
    "editor.cursorBlinking" = "smooth";
    "editor.cursorSmoothCaretAnimation" = "on";
    "editor.fontFamily" = "JetBrains Mono";
    "editor.fontLigatures" = true;
    "editor.fontSize" = 13;
    "editor.fontWeight" = "500";
    "editor.formatOnSave" = true;
    "editor.guides.bracketPairs" = true;
    "editor.guides.indentation" = true;
    "editor.inlayHints.fontSize" = 11;
    "editor.inlayHints.padding" = true;
    "editor.inlineSuggest.enabled" = true;
    "editor.linkedEditing" = true;
    "editor.lineHeight" = 22;
    "editor.minimap.enabled" = false;
    "editor.renderLineHighlight" = "all";
    "editor.semanticHighlighting.enabled" = true;
    "editor.showUnused" = true;
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
    "files.insertFinalNewline" = true;
    "files.trimTrailingWhitespace" = true;
  };

  telemetry = {
    "redhat.telemetry.enabled" = false;
    "telemetry.telemetryLevel" = "off";
  };

  terminal = {
    "terminal.integrated.fontSize" = 13;
    "terminal.integrated.gpuAcceleration" = "on";
  };

  window = {
    "window.commandCenter" = false;
    "window.dialogStyle" = "native";
    "window.menuBarVisibility" = "toggle";
    "window.titleBarStyle" = "custom";
  };

  workbench = {
    "workbench.colorTheme" = "GitHub Dark Default";
    "workbench.iconTheme" = "material-icon-theme";
    "workbench.productIconTheme" = "icons-carbon";
    "workbench.layoutControl.enabled" = false;
    "workbench.startupEditor" = "none";
    "workbench.activityBar.location" = "top";
    "workbench.sideBar.location" = "right";
    "workbench.tree.indent" = 16;
    "workbench.editor.empty.hint" = "hidden";
  };

  # extension specific
  git = {
    "git.autofetch" = true;
    "git.enableCommitSigning" = true;
    "git.enableSmartCommit" = true;
    "git.openRepositoryInParentFolders" = "always";
    "gitblame.inlineMessageEnabled" = true;
    "gitblame.inlineMessageFormat" = "\${author.name} (\${time.ago}) - \${commit.summary}";
  };

  error-lens = {
    "errorLens.gutterIconsEnabled" = true;
    "errorLens.gutterIconSet" = "defaultOutline";
  };

  path-intellisense = {
    "path-intellisense.autoSlashAfterDirectory" = true;
    "path-intellisense.autoTriggerNextSuggestion" = true;
    "path-intellisense.extensionOnImport" = true;
    "path-intellisense.showHiddenFiles" = true;
  };

  # language specific
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

  go = {
    "go.inlayHints.assignVariableTypes" = true;
    "go.inlayHints.constantValues" = true;
    "go.inlayHints.parameterNames" = true;
    "go.inlayHints.rangeVariableTypes" = true;

    "go.alternateTools" = {
      "gofumpt" = "${pkgs.gofumpt}/bin/gofumpt";
      "golangci-lint" = "${pkgs.golangci-lint}/bin/golangci-lint";
      "gomodifytags" = "${pkgs.gomodifytags}/bin/gomodifytags";
      "gopls" = "${pkgs.gopls}/bin/gopls";
      "impl" = "${pkgs.impl}/bin/impl";
      "staticcheck" = "${pkgs.go-tools}/bin/staticcheck";
      "delve" = "${pkgs.delve}/bin/dlv";
    };

    "go.lintTool" = "golangci-lint";

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
  };

  java = {
    "java.configuration.runtimes" = [
      {
        name = "JavaSE-17";
        path = "${pkgs.jdk17}/lib/openjdk";
        default = true;
      }
    ];
    "java.format.settings.profile" = "GoogleStyle";
    "java.jdt.ls.java.home" = "${pkgs.jdk17}/lib/openjdk";
  };

  nix = {
    "nix.enableLanguageServer" = true;
    "nix.formatterPath" = "${pkgs.alejandra}/bin/alejandra";
    "nix.serverPath" = "${pkgs.nil}/bin/nil";
    "nix.serverSettings"."nil"."formatting"."command" = ["${pkgs.alejandra}/bin/alejandra"];
  };

  python = {
    "python.defaultInterpreterPath" = "${pkgs.python3}/bin/python";
    "python.languageServer" = "Pylance";
    "python.analysis.typeCheckingMode" = "strict";
    "python.analysis.autoFormatStrings" = true;
  };
in {
  programs.vscode.userSettings =
    {
      "diffEditor.hideUnchangedRegions.enabled" = true;

      "search.exclude" = {
        "**/bower_components" = true;
        "**/env" = true;
        "**/node_modules" = true;
        "**/pnpm-lock.yaml" = true;
        "**/venv" = true;
      };

      "files.watcherExclude" = {
        "**/.git/objects/**" = true;
        "**/.git/subtree-cache/**" = true;
        "**/node_modules/**" = true;
        "**/env/**" = true;
        "**/venv/**" = true;
        "env-*" = true;
      };
    }
    # general
    // editor
    // breadcrumbs
    // explorer
    // files
    // telemetry
    // terminal
    // window
    // workbench
    # extension specific
    // git
    // error-lens
    // path-intellisense
    # language specific
    // formatter
    // go
    // java
    // nix
    // python;
}
