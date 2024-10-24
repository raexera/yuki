{
  programs.vscode.keybindings = [
    {
      "key" = "alt+f";
      "command" = "editor.action.formatDocument";
      "when" = "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor";
    }
  ];
}
