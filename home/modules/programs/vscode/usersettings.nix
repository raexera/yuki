{pkgs, ...}: let
  general = {
    "extensions.ignoreRecommendations" = true;
    "extensions.autoCheckUpdates" = false;
    "extensions.autoUpdate" = false;
    "update.mode" = "none";
    "update.showReleaseNotes" = false;
    "redhat.telemetry.enabled" = false;
    "telemetry.telemetryLevel" = "off";
  };

  editor = {
    "editor.bracketPairColorization.enabled" = true;
    "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
    "editor.cursorBlinking" = "smooth";
    "editor.cursorSmoothCaretAnimation" = "on";
    "editor.folding" = true;
    "editor.fontFamily" = "'JetBrainsMono NFP', 'Droid Sans Mono', 'monospace', monospace";
    "editor.fontLigatures" = true;
    "editor.fontSize" = 16;
    "editor.fontWeight" = "500";
    "editor.formatOnPaste" = true;
    "editor.formatOnSave" = true;
    "editor.formatOnType" = true;
    "editor.guides.bracketPairs" = true;
    "editor.guides.indentation" = true;
    "editor.inlayHints.fontSize" = 12;
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
      "source.addMissingImports" = "always";
      "source.fixAll" = "always";
      "source.organizeImports" = "always";
      "source.removeUnusedImports" = "always";
      "source.sortImports" = "always";
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

  terminal = {
    "terminal.integrated.fontFamily" = "'JetBrainsMono NFP', 'Droid Sans Mono', 'monospace', monospace";
    "terminal.integrated.fontSize" = 16;
    "terminal.integrated.gpuAcceleration" = "on";
    "terminal.integrated.minimumContrastRatio" = 1;
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
    "workbench.colorTheme" = "Catppuccin Macchiato";
    "workbench.iconTheme" = "catppuccin-macchiato";
    "workbench.layoutControl.enabled" = false;
    "workbench.panel.defaultLocation" = "bottom";
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

    # errorLens
    "errorLens.gutterIconsEnabled" = true;
    "errorLens.gutterIconSet" = "defaultOutline";

    # eslint
    "eslint.format.enable" = true;
    "eslint.problems.shortenToSingleLine" = true;
    "eslint.validate" = [
      "javascript"
      "typescript"
      "javascriptreact"
      "typescriptreact"
      "astro"
      "svelte"
    ];

    # prettier
    "prettier.jsxSingleQuote" = true;

    # svelte
    "svelte.enable-ts-plugin" = true;
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
    "[scss]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[svelte]"."editor.defaultFormatter" = "svelte.svelte-vscode";
    "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[typescriptreact]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
  };

  # Language specific settings
  language = {
    # go
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

    # typescript
    "typescript.inlayHints.functionLikeReturnTypes.enabled" = true;
    "typescript.inlayHints.parameterNames.enabled" = "all";
    "typescript.inlayHints.parameterTypes.enabled" = true;
    "typescript.inlayHints.propertyDeclarationTypes.enabled" = true;
    "typescript.preferGoToSourceDefinition" = true;
    "typescript.suggest.completeFunctionCalls" = true;

    # javascript
    "javascript.inlayHints.functionLikeReturnTypes.enabled" = true;
    "javascript.inlayHints.parameterNames.enabled" = "all";
    "javascript.inlayHints.parameterTypes.enabled" = true;
    "javascript.inlayHints.propertyDeclarationTypes.enabled" = true;
    "javascript.preferGoToSourceDefinition" = true;
    "javascript.suggest.completeFunctionCalls" = true;

    # java
    "java.configuration.runtimes" = [
      {
        name = "JavaSE-17";
        path = "${pkgs.jdk17}/lib/openjdk";
        default = true;
      }
    ];
    "java.format.settings.profile" = "GoogleStyle";
    "java.jdt.ls.java.home" = "${pkgs.jdk17}/lib/openjdk";

    # nix
    "nix.enableLanguageServer" = true;
    "nix.formatterPath" = "${pkgs.alejandra}/bin/alejandra";
    "nix.serverPath" = "${pkgs.nil}/bin/nil";
    "nix.serverSettings"."nil"."formatting"."command" = ["${pkgs.alejandra}/bin/alejandra"];
  };
in {
  programs.vscode.userSettings =
    general
    // editor
    // breadcrumbs
    // explorer
    // files
    // terminal
    // window
    // workbench
    // extension
    // formatter
    // language;
}
