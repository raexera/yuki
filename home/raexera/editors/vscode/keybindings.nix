{
  programs.vscode.keybindings = [
    {
      "key" = "ctrl+`";
      "command" = "workbench.action.terminal.focus";
      "when" = "editorTextFocus";
    }
    {
      "key" = "ctrl+`";
      "command" = "workbench.action.focusActiveEditorGroup";
      "when" = "terminalFocus";
    }
    {
      "key" = "alt+f";
      "command" = "editor.action.formatDocument";
      "when" = "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor";
    }
  ];
}
