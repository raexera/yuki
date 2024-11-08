{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    act
    gh
    gist
    gitflow
    lefthook
    zsh-forgit
  ];

  programs = {
    git = {
      enable = true;
      package = pkgs.gitFull;

      userName = "raexera";
      userEmail = "raexera@gmail.com";

      signing = {
        key = config.programs.gpg.settings.default-key;
        signByDefault = true;
      };

      lfs = {
        enable = true;
        skipSmudge = true;
      };

      extraConfig = {
        credential.helper = "${pkgs.gitFull}/bin/git-credential-libsecret";

        init.defaultBranch = "main";
        branch.autosetupmerge = "true";
        pull.ff = "only";
        color.ui = "auto";

        push = {
          default = "current";
          followTags = true;
          autoSetupRemote = true;
        };

        merge = {
          conflictstyle = "diff3";
          stat = "true";
        };

        rebase = {
          autoSquash = true;
          autoStash = true;
        };

        rerere = {
          enabled = true;
          autoupdate = true;
        };
      };

      aliases = {
        a = "add";
        af = "!git add $(git ls-files -m -o --exclude-standard | sk -m)";
        b = "branch";
        br = "branch";
        c = "commit";
        ca = "commit --amend";
        cm = "commit -m";
        co = "checkout";
        d = "diff";
        ds = "diff --staged";
        edit-unmerged = "!f() { git ls-files --unmerged | cut -f2 | sort -u ; }; hx `f`";
        essa = "push --force";
        fuck = "commit --amend -m";
        graph = "log --all --decorate --graph --oneline";
        hist = "log --pretty=format:\"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)\" --graph --date=relative --decorate --all";
        l = "log";
        llog = "log --graph --name-status --pretty=format:\"%C(red)%h %C(reset)(%cd) %C(green)%an %Creset%s %C(yellow)%d%Creset\" --date=relative";
        oops = "checkout --";
        p = "push";
        pf = "push --force-with-lease";
        pl = "!git pull origin $(git rev-parse --abbrev-ref HEAD)";
        ps = "!git push origin $(git rev-parse --abbrev-ref HEAD)";
        r = "rebase";
        s = "status --short";
        ss = "status";
      };

      ignores = [
        "*~"
        "*.swp"
        "*result*"
        ".direnv"
        "node_modules"
      ];
    };
  };
}
