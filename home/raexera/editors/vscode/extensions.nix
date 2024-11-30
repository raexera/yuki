{pkgs, ...}: {
  programs.vscode = {
    mutableExtensionsDir = true;
    extensions = with pkgs.vscode-marketplace; [
      alefragnani.project-manager
      astro-build.astro-vscode
      bradlc.vscode-tailwindcss
      cardinal90.multi-cursor-case-preserve
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
      naumovs.color-highlight
      oderwat.indent-rainbow
      redhat.vscode-yaml
      renesaarsoo.sql-formatter-vsc
      rust-lang.rust-analyzer
      svelte.svelte-vscode
      tamasfe.even-better-toml
      usernamehw.errorlens
      yzhang.markdown-all-in-one
    ];
  };
}
